Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44E858E94C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 11:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbiHJJIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 05:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbiHJJIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 05:08:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706EF76479
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:08:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA6C960F9B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:08:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A596C433D7;
        Wed, 10 Aug 2022 09:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660122497;
        bh=fnXaYwu3upLYBGaCBhQVJsI6d8huckYTIO7QAKu6jbw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YzqWJvJljaFP+0uMFd6W7GvVRh+qxWz5GANjJX6mGnttSqImwNuSFc3PgYyc8x7i1
         x9ZurvdkivxUh1CGzMHoxlATklGYYuFeK9uvrlzNjjn4jarVnppp2Js/TAezDVrqBF
         M0jeIrimVCAwmF/tfqu/8hXguXVl2CRgc9X+EtmimwVhWgpAsjGrTuBGneOdtmiqlL
         ljD+kBpAqL2Bih/bQkrk9Ur38XgBBT0rPJ1Dse10CT2u3MHaEjG7HRat0e0H9hDO96
         z+5pghP0Iu2HjlXgnZM3opdGcm4oLPAqK1Mlzp3L0TdPSf8lrJBGkfnucqEsLQzq/K
         7SoqgfXU7UQ8g==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1oLhhH-0025nz-07;
        Wed, 10 Aug 2022 10:08:15 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     oliver.upton@linux.dev, suzuki.poulose@arm.com,
        james.morse@arm.com, alexandru.elisei@arm.com
Subject: Re: [PATCH v3] KVM: arm64: fix compile error because of shift overflow
Date:   Wed, 10 Aug 2022 10:08:10 +0100
Message-Id: <166012247956.2742754.12984698031789785989.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220810013435.1525363-1-yangyingliang@huawei.com>
References: <20220810013435.1525363-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, yangyingliang@huawei.com, linux-kernel@vger.kernel.org, oliver.upton@linux.dev, suzuki.poulose@arm.com, james.morse@arm.com, alexandru.elisei@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2022 09:34:35 +0800, Yang Yingliang wrote:
> Using GENMASK() to generate the masks of device type and device id, it makes
> code unambiguous, also it can fix the following fix compile error because of
> shift overflow when using low verison gcc(mine version is 7.5):
> 
> In function ‘kvm_vm_ioctl_set_device_addr.isra.38’,
>     inlined from ‘kvm_arch_vm_ioctl’ at arch/arm64/kvm/arm.c:1454:10:
> ././include/linux/compiler_types.h:354:38: error: call to ‘__compiletime_assert_599’ \
> declared with attribute error: FIELD_GET: mask is not constant
>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)

Applied to fixes, thanks!

[1/1] KVM: arm64: fix compile error because of shift overflow
      commit: ae3b1da95413614f96ffa23d200929c6f809c807

Cheers,

	M.
-- 
Marc Zyngier <maz@kernel.org>

