Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8DD50A748
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390831AbiDURk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345437AbiDURk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:40:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1683E49F9A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650562685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tRNqBkJETfPubt9Dm0CAyv1GilqtUrQGY4UheZs4bjI=;
        b=MmZl+V08ejtGVH7lolpoF7Pou6hPsNc34IlLkHADeZgmgGyhqWClXiy35ZYYSgv5ZoBQX7
        5CvjDJSCAoAtiGA79MnjRDzM2sbkGKJitXOlJr5SHIIfzHF/9jGZ6iuIqQkbeolHatGGSY
        JpVbBTqpJ1R847O8XvSIY9lXlS2SqQo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-qUxz6sf_Pkiuanxv5y2oHQ-1; Thu, 21 Apr 2022 13:38:04 -0400
X-MC-Unique: qUxz6sf_Pkiuanxv5y2oHQ-1
Received: by mail-qv1-f71.google.com with SMTP id m16-20020ad45050000000b00446393a7a9fso4533912qvq.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tRNqBkJETfPubt9Dm0CAyv1GilqtUrQGY4UheZs4bjI=;
        b=AxOLRDl+/ycsD0MO4bJnhkkZERiHzWXhvA5XODwGYx83mJRBLEZrCWK3cacQ0M5HGZ
         VspQaOJoVXkuRXSRmdDwbeJBTlCn29EZsY6Ms7PieZhui7oXUQhiv73JKXeIZw5vWIts
         L4sFL5twj4+85MxXXtQe2UUdvQu2k374MNxZdfaNBNn32nAe4RL04yInzxsGouThhnwy
         Rcgon+jvT6hQhbxIomlKytvjd/nouBuLHZalpIoTBJ4wm/J1333zexwOIPqKNWjbov2C
         p40bdxvM5n3mne+7SD4rbT0ZTATa83HEZcp1vgw6cbXmhbwUEadAyp9qS7CR8fWW3BiR
         NUtQ==
X-Gm-Message-State: AOAM530BFSGMXGlKwmj/ZBxNl9ji+1IJI+5yU77QiEOXElu947Fgbezs
        6J/D0fmNAcH1WTV3NG2gD+dmAD35IeejstLenf04qHcBW/kOzR7XEFymeq8PV5VDHYhWD+JID/R
        mb9WdtBoZmBVz2FTWxt0YpOcb
X-Received: by 2002:a05:620a:2493:b0:69c:4dbf:c75f with SMTP id i19-20020a05620a249300b0069c4dbfc75fmr396360qkn.116.1650562683468;
        Thu, 21 Apr 2022 10:38:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCO4SyG2BwTxN/19jkyZBlsVHQU6BZ78v9igkqRv3QLdv+agC+RU0YTN2iYVVKHoI1nc3kVw==
X-Received: by 2002:a05:620a:2493:b0:69c:4dbf:c75f with SMTP id i19-20020a05620a249300b0069c4dbfc75fmr396344qkn.116.1650562683232;
        Thu, 21 Apr 2022 10:38:03 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id p13-20020a05622a048d00b002e1ce0c627csm4056892qtx.58.2022.04.21.10.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 10:38:02 -0700 (PDT)
Date:   Thu, 21 Apr 2022 10:37:59 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Miroslav Benes <mbenes@suse.cz>, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3] scripts: Create objdump-func helper script
Message-ID: <20220421173759.ijvytapqhoqpt22n@treble>
References: <4d3ab1f17230f0188698cfbc7ba08696fe1abfe9.1650474927.git.jpoimboe@redhat.com>
 <20220421085244.GL2731@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220421085244.GL2731@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 10:52:44AM +0200, Peter Zijlstra wrote:
> On Wed, Apr 20, 2022 at 10:16:36AM -0700, Josh Poimboeuf wrote:
> 
> > +${OBJDUMP} -wdr $OBJ | gawk -M -v f=$FUNC '/^$/ { P=0; } $0 ~ "<" f ">:" { P=1; O=strtonum("0x" $1); } { if (P) { o=strtonum("0x" $1); printf("%04x ", o-O); print $0; } }'
> 
> Two noteworthy changes:
> 
>  - $@ went missing, I've occasionally abused that to add extra argument
>    to objdump.

Just to clarify, you'd add the extra arg at the end like this, right?

  objdump-func <file> <func> -Mintel

>  - you removed the glob after FUNC, I had that so that .cold and
>    .constprop etc.. variants of the function also show up.

Sure, I'll match ".whatever" if there's a period, but not other
substring matches, e.g. "put_page" shouldn't match "put_pages_list".

  {OBJDUMP} -wdr $@ $OBJ | gawk -M -v f=$FUNC '/^$/ { P=0; } $0 ~ "<" f "(\\..*)?>:" { P=1; O=strtonum("0x" $1); } { if (P) { o=strtonum("0x" $1); printf("%04x ", o-O); print $0; } }'


-- 
Josh

