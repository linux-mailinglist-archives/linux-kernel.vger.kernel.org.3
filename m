Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D504DE508
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 02:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241732AbiCSBhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 21:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiCSBhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 21:37:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E8D91AD3A6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 18:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647653742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3Yhdauiv/hGwfTz79ujnlgoXkowLnIQTmrPreufHZAY=;
        b=K/vQUQ9IHir1hI06gRXhTJ207CCgk26TaLLP9v3NJ7xF5HKSKav4C60rWLgid6N32sYCHf
        1vkxRxcvDWmiKJkhF28y49dP6IksmJh0iOOYEPNKOqkalbXeGvIGxhgkhQ3DPM95P90/3A
        GLMBvuonjC6euMHzeXJ2NPsHjiFZmlA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121-BKZQhYOtMXiuUUNLI6I7ng-1; Fri, 18 Mar 2022 21:35:41 -0400
X-MC-Unique: BKZQhYOtMXiuUUNLI6I7ng-1
Received: by mail-qv1-f71.google.com with SMTP id ba7-20020ad45527000000b0044105fb3d5fso1605412qvb.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 18:35:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3Yhdauiv/hGwfTz79ujnlgoXkowLnIQTmrPreufHZAY=;
        b=MeQ6QWfJnahY3kDT0FctmzIEnI+1r7+mHJvhwOBW0xl6nlLuOy8Na0AqGFKU7epw9z
         n+Wl5XAaadS2D5vx1lO+Wu9fTmoD88OsDoxW6CBojsgz3VBdf+fJdZ4WUjlXgXenzcO6
         UY+cHpiZC5vNdxU+2IugUcKui7hUcvXbOn3t7RBOn6HlIH0hZUA7spSHYoBVexTrAHzk
         s8KyRSnMpcG9WGbi7Wk6UsO1iDpDTaGHd3ntU2UeEGSw9GQm+4anXHWpov3dpcBBwOIA
         KzTFdiAsBvWZ2m4e1KDppQOE/5IAmBhxQp784tff34aQeyLlzGHtJlO8Vi+/pRZLPEIV
         ZWHw==
X-Gm-Message-State: AOAM531FikK3NwXYyd6o3l1NtVWuz14dhRxZqaATAk1EpbgLpiNimggy
        2Hv3yxDd9A6jwECglsEbLDYSN3Dk6iNYyGXcXZxYOh0V+qlncfAdv9Kl9n2/LIB7gMK8/urK7G1
        BErJ+QVwbUGLExu9bezWGpu+t
X-Received: by 2002:a05:6214:262a:b0:440:d51b:71d8 with SMTP id gv10-20020a056214262a00b00440d51b71d8mr8957939qvb.58.1647653739939;
        Fri, 18 Mar 2022 18:35:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFZ8FUzHQ/tF7I6xSgadbQibeZis7TglzPOIMyT0wgA1z0OwQ5PrduuzpXsh1YaDRWwJmJfQ==
X-Received: by 2002:a05:6214:262a:b0:440:d51b:71d8 with SMTP id gv10-20020a056214262a00b00440d51b71d8mr8957931qvb.58.1647653739643;
        Fri, 18 Mar 2022 18:35:39 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id n7-20020a05622a040700b002e1b8be0985sm6436353qtx.35.2022.03.18.18.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 18:35:39 -0700 (PDT)
Date:   Fri, 18 Mar 2022 18:35:36 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sathvika Vasireddy <sv@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
        rostedt@goodmis.org, naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [RFC PATCH 0/3] objtool: Add mcount sub-command
Message-ID: <20220319013536.v2syx2ru7ijuvw23@treble>
References: <20220318105140.43914-1-sv@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220318105140.43914-1-sv@linux.ibm.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 04:21:37PM +0530, Sathvika Vasireddy wrote:
> This patchset adds support to implement 'objtool mcount' command.
> 
> Right now, objtool is built if CONFIG_STACK_VALIDATION is enabled.
> And, '__mcount_loc' section is generated by objtool when --mcount 
> option is passed to check sub-command. 
> 
> For architectures to be able to generate '__mcount_loc' section
> without having to do stack validation, introduce 'mcount' as
> a sub-command to objtool. This way, objtool is built for mcount 
> if CONFIG_FTRACE_MCOUNT_USE_OBJTOOL is enabled. Additionally, 
> architectures can select HAVE_NOP_MCOUNT to be able to nop out
> mcount call sites.  
> 
> TODO: Enable "objtool mcount" for clang LTO builds.
> 
> Sathvika Vasireddy (3):
>   objtool: Move common code to utils.c
>   objtool: Enable and implement 'mcount' subcommand
>   objtool/mcount: Add powerpc specific functions

Hi Sathvika,

Thanks for the patches!

I have some other patches in progress which will rework the objtool
interface by modularizing the cmdline options, so that each option can
be specified either individually or in combination.  Even stack
validation itself will be its own separate option.

I think it will help your situation as well: "objtool run --mcount" will
only do '__mcount_loc' generation and nothing else.

Something like so:

$ ./objtool run --help

 Usage: objtool run [<options>] file.o

Commands (at least one required):
    -a, --uaccess         validate uaccess
    -c, --static-call     annotate static calls
    -i, --ibt             validate and annotate IBT
    -m, --mcount          generate '__mcount_loc' section
    -n, --noinstr         validate noinstr
    -o, --orc             generate ORC metadata
    -r, --retpoline       validate retpoline usage
    -S, --sls             validate straight-line-speculation mitigation
    -s, --stack-val       validate stack metadata

Options:
        --backtrace       unwind on error
        --backup          create .orig files before modification
        --dry-run         don't write the modifications
        --fp              object uses frame pointers
        --module          object will be part of a kernel module
        --no-unreachable  skip 'unreachable instruction' warnings
        --stats           print statistics
        --vmlinux         object is vmlinux.o


Hopefully I'll have the patches ready soon.

-- 
Josh

