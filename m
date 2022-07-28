Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69259583F02
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238777AbiG1Mja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238111AbiG1Mj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:39:29 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DB96B25E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 05:39:27 -0700 (PDT)
Received: from quatroqueijos (1.general.cascardo.us.vpn [10.172.70.58])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id C80523F3DD;
        Thu, 28 Jul 2022 12:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1659011965;
        bh=75Fs+7OtzhiiwfyqgBMScoOSkC52NZRQ6WT06XCbCYs=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=rrqjLi5E9gacIoNn+yoc4V8aoioxwlrJHfqaLdmaxXRLtxgMW0eMJXd12LvC36A4A
         +EwbMKPSbzghXkncSGquqYxxTgZzbAMgHt/LljiyeVoVUFNKMZdQVL+j+oQN6Jyh0e
         41pGe3t7WNzMqIEGQwvbS127NXwrhc7e/2GSysmBgVZEazoTTLnlvRSiTJSMvtaR3S
         Kiaj6fkJlB9xsEgLi6GvUIWfck3OS8u1H6KpE3E7hhwEtWUvow+zOsjYyXejBGQT1D
         LQctTNS6onDOauV15E6ysWFjP9vVwvukUB8HWcUmuS2vdGyx6voGvbIVVS7NY9s2LW
         NzB1bhKUUrg9w==
Date:   Thu, 28 Jul 2022 09:39:20 -0300
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86/bugs: Do not enable IBPB at firmware entry when IBPB
 is not available
Message-ID: <YuKDeFg8TtV9zcw9@quatroqueijos>
References: <20220728122602.2500509-1-cascardo@canonical.com>
 <YuKCpLOLeDOI7GII@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuKCpLOLeDOI7GII@zn.tnic>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 02:35:48PM +0200, Borislav Petkov wrote:
> drop stable@
> 
> On Thu, Jul 28, 2022 at 09:26:02AM -0300, Thadeu Lima de Souza Cascardo wrote:
> > Some cloud hypervisors do not provide IBPB on very recent CPU processors,
> > including AMD processors affected by Retbleed.
> 
> Which hypervisors are those? How relevant is that use case?

Azure for sure, and I guess AWS would be affected as well.

> 
> How do I reproduce it here?
> 

qemu -cpu host,ibpb=off on an affected AMD processor worked for me. With EFI,
so with something like -drive if=pflash,index=0,file=OVMF_CODE_4M.fd -drive
if=pflash,index=1,file=OVMF_VARS_4M.fd.

Cascardo.

> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
