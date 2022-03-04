Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF0B4CDB55
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241324AbiCDRxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241077AbiCDRws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:52:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C960DF540F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 09:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646416319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=86mrUfY2a9ejGUqsBn3YNiqPHJtfi4XwtVYGZkB1VoI=;
        b=Usxcnt/h1hIBmCqITwyCvJl/Q3giNCNcP7geVxUIj14ZGgKW7MsgMR0lFz+SqerlUUWJXb
        9V5BYUi6LaA5I3OuVbnLOV5Y+YG6nw0hbwTkhJx9iX20qAD0M2TZ7nEcWjJUI+A7y5eFUZ
        ygG07X6vRbrcc32Xe1a98UImLqvSDwA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-tGefMWhJNB6Lhnwnuageow-1; Fri, 04 Mar 2022 12:51:58 -0500
X-MC-Unique: tGefMWhJNB6Lhnwnuageow-1
Received: by mail-qv1-f72.google.com with SMTP id kj16-20020a056214529000b00435218e0f0dso6963871qvb.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 09:51:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=86mrUfY2a9ejGUqsBn3YNiqPHJtfi4XwtVYGZkB1VoI=;
        b=RQRg94SztjhMXmiZqej2oXGM/fIUNHN4MkTGGOE4uBeJPASi+UZNhUb/sNnESAYfAq
         nuKV7M+6/ly61pds3YO63vYNp9fl1B8EXxR3HRmvFKY8QM8pvvr8V8lQtDieGY7BfgQv
         Vs6u6pXzgiVSXUwaeI1FFWi3h3kwD7UScszbY1m7e8ZgLkbWIVUvCk3PFuodcNydrCy8
         jgyFQz1IAHymBTUnNh05Xz2bRIjJ/ignfdiX92D7g8a6QI1sCAW+FDkZ5wJebtYZrGt4
         s7OXaK7/P/DjxQpB+5KotsYuSByvssN+c0/sfYyvIPKWm2e8oF/l1TbP8o0jFvVQ+wja
         NbAg==
X-Gm-Message-State: AOAM533CKN3b8ZYOyb4ap0XZZUQqdpPq2hSTdkJM+ofNwCT2YxguUgi0
        MS1rmIW4ZGOjZiHWtRocjnv+/UZaOmejohr2yQvGcPaMMh53tQp3sryhDyXsgQSuGCpGcyZHh49
        jnFPdY4dArNAch3IbHmFXsAGD
X-Received: by 2002:ac8:5c81:0:b0:2dd:97b6:bcc7 with SMTP id r1-20020ac85c81000000b002dd97b6bcc7mr31957889qta.412.1646416318262;
        Fri, 04 Mar 2022 09:51:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxrsDf+lFMFbKsg+RAf+Xo+xL1ldUCMaKwwpQ59zzfNS4Hn90y1mfeHGW9OAi0wwh9snVf8WA==
X-Received: by 2002:ac8:5c81:0:b0:2dd:97b6:bcc7 with SMTP id r1-20020ac85c81000000b002dd97b6bcc7mr31957863qta.412.1646416317989;
        Fri, 04 Mar 2022 09:51:57 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id 6-20020a05620a040600b005f177d938dbsm2710224qkp.66.2022.03.04.09.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 09:51:57 -0800 (PST)
Date:   Fri, 4 Mar 2022 09:51:54 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v3 18/39] x86/ibt,ftrace: Make function-graph play nice
Message-ID: <20220304175154.l2otvmqd4r7ozsuy@treble>
References: <20220303112321.422525803@infradead.org>
 <20220303112826.044301664@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220303112826.044301664@infradead.org>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 12:23:39PM +0100, Peter Zijlstra wrote:
> +
> +	addq $16, %rsp
> +	ANNOTATE_INTRA_FUNCTION_CALL
> +	call .Ldo_rop
> +	int3
> +.Ldo_rop:
> +	mov %rdi, (%rsp)
> +	UNWIND_HINT_FUNC
> +	RET

Why the int3?

-- 
Josh

