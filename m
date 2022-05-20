Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51D452F1EE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 19:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352350AbiETR5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 13:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236711AbiETR4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 13:56:50 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B01583A9;
        Fri, 20 May 2022 10:56:49 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id a22so7484927qkl.5;
        Fri, 20 May 2022 10:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VuGDa2jgu72TauqLjiFjUsmCZzpkcyEUpD7gxOBdg3k=;
        b=lDEToUVZNPxrcpfSG1zCTM07fmc1FG0+UGlKqQVfNotPaGL/m2+WTcRHsgOTBBB9FZ
         7GDlQNi6IasuZwoRejfAs/SAuL+1p39QCpPtuAfpExA0gX+8XMGe2NPdI2wLUUKoSFQU
         rx/ZyumYMPmjU1GJDuNuvp6lT+629je9/HJpdRavvCR6vywEbpJ0uEl0RqsoGcUb+dWw
         vpLR2zc5iRHcjOJbZM1WZroEMXVmjKg12XCT/VTVhVVJUe+4Eys5JjbLyjG51gxiFic2
         Pv0bXph/ldm7ON6NVq2hEx0WWFPwalMYj4NaD+Az3T1VUM9EgMFbSgVQexM7aRYgR0aO
         VGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VuGDa2jgu72TauqLjiFjUsmCZzpkcyEUpD7gxOBdg3k=;
        b=Y73hsJUBLhuq6ilyOPqVo6GrAn8+iOraWVf1SaQaO8skvtBxIozGgu5DoiJjpZUCgm
         f0EkCB4lh9RCzd6Gft2f+kJ+EdfJ2w6LOakasW+LTAO8OsftbsDdUz2VmP2Fu/GBJ/2F
         oURcA+sB4pEsh8DkhVO1eerOKFOTqQSMqPtgPB0B3v0b8dp8J5CcBCaaYZNosj5BtaB4
         dNcfLkZ4rxx6X6nOqLLcKE2gAVRLcvPC0vsHtkBszVHyKRn8WnOVVHGmG8a5PQ5XuyiP
         dixMcpSLTZLMQ/RuNMZd/oPkKm1tefIXysvnJjYPpdw5OxjzxKGAVqgSgtTOz1jrZHVW
         6xzw==
X-Gm-Message-State: AOAM531FnYfqSs9Q3PSRCMK1lXiTX1ybdsTpdAv/stJRR/BDlSfR24q0
        fTfkISfOrHxzhLZvHw4eTA==
X-Google-Smtp-Source: ABdhPJxAmfjvOpKRx+dSKD1ueaP9AQDwP503dDpC99vb7F0wnY/40EPbjnYxuU9rnbvyaIPWk4lVMQ==
X-Received: by 2002:a05:620a:1981:b0:507:4a52:f310 with SMTP id bm1-20020a05620a198100b005074a52f310mr7203747qkb.611.1653069408151;
        Fri, 20 May 2022 10:56:48 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id d23-20020a05620a167700b006a32c4a2cb8sm66374qko.52.2022.05.20.10.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 10:56:47 -0700 (PDT)
Date:   Fri, 20 May 2022 13:56:45 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, willy@infradead.org
Subject: Re: [PATCH v2 03/28] vsprintf: %pf(%p)
Message-ID: <20220520175645.bdv6zsenrqutywlc@moria.home.lan>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
 <20220519172421.162394-4-kent.overstreet@gmail.com>
 <YodF6C9ib2/kh5px@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YodF6C9ib2/kh5px@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 09:40:24AM +0200, Michal Hocko wrote:
> On Thu 19-05-22 13:23:56, Kent Overstreet wrote:
> [...]
> > The goal is to replace most of our %p format extensions with this
> > interface, and to move pretty-printers out of the core vsprintf.c code -
> > this will get us better organization and better discoverability (you'll
> > be able to cscope to pretty printer calls!), as well as eliminate a lot
> > of dispatch code in vsprintf.c.
> 
> Is this really something that we want? While I do see arguments about
> our existing %p$FOO mess there is at least one good argument to have all
> those "pretty printers" at a single location. That approach allows to do
> a proper review whether those printers are safe from the printk point of
> view. If we allow any random callback to be called from the printk
> context we just give a free ticket to anybody to do whatever from there
> without understanding of all potential consequences. 
> 
> Maybe that is less of a concern these days when printk locking has been
> reworked a lot but I still do remember how frustrating it is to debug
> issues related to printk getting stuck...

So for now, I added a note in the documentation that pretty-printers may not
sleep if passed to printk() - but if they're just passed to pr_buf() or
sprintf() it's completely fine.
