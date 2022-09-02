Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B6D5AB79F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 19:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236814AbiIBRhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 13:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbiIBRha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 13:37:30 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723D3D34E9
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 10:37:29 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-11e9a7135easo6414448fac.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 10:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=yIW23Q2C4Gr83MEV8yMj6oMsmguEejDKJ2Nl6VMech4=;
        b=MPgjrCpJkdAg2pjrvgO0Lc9MxKf+fy9/WwEjLeTQcGhDHnPIYgtp+eXLwehzaiwWW5
         +x9Men1Iov8SAxCK/2PvgMd2Rok615f+dtNOPL0bmpCaOj+yRM9N28VdIQQB+EQjAYsD
         W/ERNigRQ8UFvl9jB/7SbPN3g+u2xfJqF/xX26AYwiUydsShrC9I+FYULuH+l46Kq9R7
         RWGamMsgFauNZqpCUJAy9tvme9mH+Q/fCJNWs7K6ps0FaAHF9Nn5EaNHWobqPjNHrjFZ
         aAuhSWW5eNRQ+73OJnQH37CYvEeMuThgaNtpNcAxziBd36IRGVNWwGfJAlukzKV0hU9R
         VwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=yIW23Q2C4Gr83MEV8yMj6oMsmguEejDKJ2Nl6VMech4=;
        b=MsrkUd0r+Tof/SAUTmcaGM9ETrVVpS9Adt2VuswdcGLWHDfJrMnU8IQwOtXKsCwDNy
         zTLiVLUsthFoN1eXnm2WDrzau1E35Y296XSTyDtexcUZFmIoCsosddKFkBCxbBbPwX90
         4ufe0KwjAFBkm5EHCRDCleFzy9Ts2jP+8OpF9nsiElClq9/cwSbykB16QKlszEyq1Z1P
         D+PluDAZomt+xgj5T0+cSywffLVg91tc1+inyxnz+dcdFwW/2XW06u3D7daibuKTR1go
         DECCM7faDwZHm13f4VHT7ercFIihOM33u+ft8oOl5itGy1O3kyNjZn19so5mq/iYgpa8
         JNYg==
X-Gm-Message-State: ACgBeo3MCx0okNEICOMe1w5a6DovnuMs7g24uJCpTTwZnL850iyJDEoR
        z0yF1bdnRvG5lg6i1F5hS0rM1bTdcL0=
X-Google-Smtp-Source: AA6agR6f86rk8GQUC7HkidMkM8Bdt/Wd+jnPEKyPDfOnFCmshMGzFj0OMICvSGHb3co+5Yw9h6nb5g==
X-Received: by 2002:a05:6870:c695:b0:101:fe5c:4759 with SMTP id cv21-20020a056870c69500b00101fe5c4759mr2887500oab.49.1662140248010;
        Fri, 02 Sep 2022 10:37:28 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id r16-20020a056830419000b00636cc9926dbsm1274727otu.40.2022.09.02.10.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 10:37:27 -0700 (PDT)
Date:   Fri, 2 Sep 2022 10:35:16 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH RFC] x86/apic: skip cpu slot reservation logic on boot in
 case of NR_CPUS == 1
Message-ID: <YxI+1OjkpFz1mE8L@yury-laptop>
References: <20220902164211.1425982-1-yury.norov@gmail.com>
 <8722acbe-c668-5b05-c030-565f8c42068c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8722acbe-c668-5b05-c030-565f8c42068c@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 10:14:51AM -0700, Dave Hansen wrote:
> On 9/2/22 09:42, Yury Norov wrote:
> > This is RFC because I'm not sure that this is not a false positive from
> > smatch. If NR_CPUS is 1, and the condition is always true, it's simply
> > optimized out by a compiler, and nothing wrong happens, except maybe a
> > couple of checks on boot.
> 
> I think it's a reasonable warning, but it's also not something we need
> to hack around.  We can surely only land in here with
> boot_cpu_detected==true if NR_CPUS==1, so the rest of the expression is
> moot.
> 
> I don't think it's worth adding the #ifdef.

Thanks Dave. Then I'll add a comment and move my series as-is.

Thanks,
Yury
