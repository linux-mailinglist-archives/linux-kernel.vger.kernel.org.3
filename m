Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8643B53BE36
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 20:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238269AbiFBSx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 14:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238246AbiFBSx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 14:53:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA13DDFD27;
        Thu,  2 Jun 2022 11:53:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D52161740;
        Thu,  2 Jun 2022 18:53:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE801C34114;
        Thu,  2 Jun 2022 18:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654196035;
        bh=6/ozTzrXSEbpvVHjeKSxu6XzYFfRCUH5ZgHkmQHksGA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bMJcXsh0Vi3CtBChclADllOSjC3myAInkA4PUeiYbl9ysmktA08EjCkucJXqjwBmw
         DZ7D7Jw6MurTb+OM73+5ZwdL7ylgsBsF9rl9UQdrNZkPOBO21ZXFycCCjGT+01fuB7
         2AobdJGnbLqNPOUOVvGoLiOC4bLkm7I16FYecqYQRCpVimn3FHEuBgrfJU+HJW8bJj
         fR6/8V7RVEiYxYqBYDMaECeAfN7A3QFj3lb8ioDDxMB3mh0SMo0ici4zaxfTS+fsgE
         9jvMZQUme5cP5KXXLjCiZOuEI1uMXAH4jer0f+WK2BEc7VEYu9D9USAZrLOLIrU/4o
         oEomtkijKLcwQ==
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-30fa61b1a83so55400377b3.0;
        Thu, 02 Jun 2022 11:53:55 -0700 (PDT)
X-Gm-Message-State: AOAM531JQOOExsWZFUTuSr1uBac6KyxG6IT/iGrJf96k4iHddhqy2DTY
        b8a6VJ8ashnuv0uNUiTCdM/wgGKvaB6hVLbymNQ=
X-Google-Smtp-Source: ABdhPJyl3Lu2iqjpZucMif8R9MuqCVV4CmyFoPmbh4LHXDZgd4Ar/sBA9vHdMqDksXXlLCSMNpwuF4A6drbWHgAiDvs=
X-Received: by 2002:a0d:fc83:0:b0:2e5:b0f4:c125 with SMTP id
 m125-20020a0dfc83000000b002e5b0f4c125mr7359325ywf.347.1654196034724; Thu, 02
 Jun 2022 11:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a1mkHEjRJgJPsRy+kuN=48=JEDJAeR2z9n+O71qbJ8hSA@mail.gmail.com>
 <6caf53e059758234ee12a236f967412f1df1f8a0.camel@linux.intel.com>
 <CAK8P3a1mHe3TkZa443fzsPnGUP1XT3w-DN3U5KAL6NBhc2nEsw@mail.gmail.com> <079945077b128fcc3cb470e9d52267f7ac763b7a.camel@linux.intel.com>
In-Reply-To: <079945077b128fcc3cb470e9d52267f7ac763b7a.camel@linux.intel.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 2 Jun 2022 20:53:38 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3aUtQ6C6kVmEZKzHv2tGL3=3WXK=_agc-Mg5Pq47vbdA@mail.gmail.com>
Message-ID: <CAK8P3a3aUtQ6C6kVmEZKzHv2tGL3=3WXK=_agc-Mg5Pq47vbdA@mail.gmail.com>
Subject: Re: x86/mce/therm_throt incorrect THERM_STATUS_CLEAR_CORE_MASK?
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Len Brown <len.brown@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 2, 2022 at 6:25 PM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Thu, 2022-06-02 at 18:18 +0200, Arnd Bergmann wrote:
> > On Thu, Jun 2, 2022 at 5:52 PM srinivas pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > >
> > > On Thu, 2022-06-02 at 11:19 +0200, Arnd Bergmann wrote:
> > > > I have a Xeon W-2265 (family 6, model 85, stepping 7) that
> > > > started
> > > > constantly spewing messages from the therm_throt driver after one
> > > > core overheated:
> > > >
> > > I think this is a Cascade Lake system. Have you tried the latest
> > > micro-
> > > code?
> >
> > Thanks for your quick reply. I have installed the latest microcode
> > 0x5003302
> > now (manually, because the version provided by the distro was still
> > using
> > version 0x5003102).
> >
> > After that, I tried writing the value 0x2a80 from userspace, and
> > that did not cause a trap, so I assume that fixed it.
> >
> Thanks for reporting.
> I am aware of this issue and should be fixed by microcode update.

I wonder how common this problem it is. Would it help to add a driver workaround
like this?

diff --git a/drivers/thermal/intel/therm_throt.c
b/drivers/thermal/intel/therm_throt.c
index 8352083b87c7..acb402e56796 100644
--- a/drivers/thermal/intel/therm_throt.c
+++ b/drivers/thermal/intel/therm_throt.c
@@ -214,7 +214,13 @@ static void clear_therm_status_log(int level)

        rdmsrl(msr, msr_val);
        msr_val &= mask;
-       wrmsrl(msr, msr_val & ~THERM_STATUS_PROCHOT_LOG);
+       if (wrmsrl_safe(msr, msr_val & ~THERM_STATUS_PROCHOT_LOG)) {
+               /* work around Cascade Lake SKZ57 erratum */
+               printk_once(KERN_WARNING "Failed to update IA32_THERM_STATUS, "
+                                       "please upgrade microcode\n");
+               wrmsrl(msr, msr_val & ~THERM_STATUS_PROCHOT_LOG &
+                       ~BIT(13) & ~BIT(15));
+       }
 }

 static void get_therm_status(int level, bool *proc_hot, u8 *temp)

        Arnd
