Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A31539587
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 19:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346617AbiEaRli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 13:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238878AbiEaRlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 13:41:37 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232C462BE5
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 10:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654018896; x=1685554896;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P69t0B2Jaz9Oq6WPSoVJEBxSVVjv0VZ1WwYPpxNmfU4=;
  b=uOnnMt6OkepmgiwxZf95HL2yJ7nGg//ecPAl2KI7wSich3ehwo0Ga8X2
   Ls5QWFa5smLnt9CWcnr0x5Y3q0g/yVjg/tyZlg6uKG1FQ3DsxBS86JpCI
   tTKFLESBzldZn81bD7XCKrBh2ee5nUoGlFKGL3L5T0+cfnrjZRKAlAoH3
   M=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 31 May 2022 10:41:35 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 10:41:35 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 31 May 2022 10:41:34 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 31 May
 2022 10:41:33 -0700
Date:   Tue, 31 May 2022 13:41:31 -0400
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Will Deacon <will@kernel.org>
CC:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: arm64: Fix memory leaks from stage2 pagetable
Message-ID: <YpZTS5R+3cisLCzl@qian>
References: <20220526203956.143873-1-quic_qiancai@quicinc.com>
 <20220531165710.GB25631@willie-the-truck>
 <20220531170157.GC25631@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220531170157.GC25631@willie-the-truck>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 06:01:58PM +0100, Will Deacon wrote:
> Have you spotted any pattern for when the leak occurs? How are you
> terminating the guest?

It just to send a SIGTERM to the qemu-system-aarch64 process. Origially,
right after sending the signal, it will remove_id/unbind from the vfio-pci
and then bind to the original (ixgbe) driver. However, since the process
might take a while to clean off itself, the bind might failed with -EBUSY.
I could reproduce it a few times one day while was unable to do so some
other days.

Later, we changed the code to make sure the process is disappeard first and
then remove_id/bind/unbind. Apparently, it make harder to reproduce if not
totally eliminate it.
