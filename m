Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9435A1BF7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 00:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244316AbiHYWLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 18:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244296AbiHYWLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 18:11:09 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCB15AA2F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:11:04 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id m66so22218370vsm.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=SB92LtmoHMRtHt7Hl06TY3zfz9SgbeIY+18JgkEA/Kw=;
        b=rxBaX9GtAHIyCKVT9OlFJ5ELgjONaqWbswYyMmc0IpaFpMhlOiy8LOLvUjFu4eG0l+
         VSSV8gc74fFwX77LQutccYWVx/2ShLo56Qjw3siRY7DJrg5ujWfL+S4qzDfHpqtXI6cM
         xpGhTDNIsT5EHPk4igSj/Jty+CpW/bPi9mvrVp0FGuJ1Ug82zxj5uK+zCInjSbujRGCH
         9+L3rFES95GOmEJgHVu9xQHLYBYSxpkAbbh17AVdbctP3VplwNAlG/PN0kSBbPA5WJHp
         HfsenyXKBo1/dJoQfQUDkut9q/v0KXUdvOUBHnD9Q14TiQ7oezOtiMKI8aUKgxZDuRS4
         IceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=SB92LtmoHMRtHt7Hl06TY3zfz9SgbeIY+18JgkEA/Kw=;
        b=wnTXLYpd8WJarzuXN4gZi8xsDVyjyZKRdB+65O57Moykq+vtJePXkm5LiLZ7GXh+kw
         Oqi+dnk55Rn07bTG22JKBU99aSGxk3BzQ4ELXwBzpBJvEGPyZA9lr+PLMg347/4fv/pM
         utP2M0mUocLPXQcmFqRbImx4R6/SNM1s6KPEs+YmgqQCaPbx6KevYdrj7PJAOQC6BL/X
         7UfOVcwlhYOsCsUBc/sfsf3fES1dlvLrska6CobvYw+5HJwipQvt2ZGkieWpN9SIrI5i
         GYGY1eZocfEO43qVtWdmzbcS2vB3cCQQ6/89yn/dGXu3xeErHshp6W5qvts6z4VOnWz0
         FEPg==
X-Gm-Message-State: ACgBeo2DQWxLe19g899Tyozr4W71HyrXpSwVhGHyn2MpLDH1VZ2QGaUl
        z5sIvMqTBIZ1Oww7CNZnbAmFXLvlgT9OORWvaHq5mOqrQJiAhg==
X-Google-Smtp-Source: AA6agR7sG+E2eIZTS8/PCVBZmFGZOXjK0hekyG2+zMof3C+l+zjS1OgUOwPyYn8TJK6I43MyYej9/F6TJpM1idvnQl0=
X-Received: by 2002:a67:e089:0:b0:390:465e:aacb with SMTP id
 f9-20020a67e089000000b00390465eaacbmr2462660vsl.4.1661465463579; Thu, 25 Aug
 2022 15:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <cover.1661437397.git.thomas.lendacky@amd.com> <fe519747d14dd16a64e0e92e4c0354cb2ec55f59.1661437397.git.thomas.lendacky@amd.com>
In-Reply-To: <fe519747d14dd16a64e0e92e4c0354cb2ec55f59.1661437397.git.thomas.lendacky@amd.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Thu, 25 Aug 2022 15:10:52 -0700
Message-ID: <CAAH4kHYVes8wezA+R9uAiNxpYCyDnwewn86tUKmeA=bjmAWGgg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] x86/sev: Add SNP-specific unaccepted memory support
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Add SNP-specific hooks to the unaccepted memory support in the boot
> path (__accept_memory()) and the core kernel (accept_memory()) in order
> to support booting SNP guests when unaccepted memory is present. Without
> this support, SNP guests will fail to boot and/or panic() when unaccepted
> memory is present in the EFI memory map.
>
> The process of accepting memory under SNP involves invoking the hypervisor
> to perform a page state change for the page to private memory and then
> issuing a PVALIDATE instruction to accept the page.

Thanks for this update! Tests show the boot performance shaves off a
good few seconds over eager acceptance, and it'll get better when we
have on-demand pinning.

The uncaught #VC exception is still there for 256GB machines and larger though.

-- 
-Dionna Glaze, PhD (she/her)
