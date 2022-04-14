Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6AE5019F3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245114AbiDNRYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240799AbiDNRYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:24:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D05CBBC85D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 10:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649956924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i/2YUxZHXeRUBoBs87Jt7Yv5tGwLCyCxoPCR5L1KNRo=;
        b=XmvI2loGuqlSwuwXjARDBEhj15KqVcnoZ0PUGOKPNGr3dJdSVFDWywJ3GL5HhGhXs/oVML
        1Gj/10VZWgwaEAHsVu4sWQMstPJf4DVfszffraHdHRZwZSdK7dazqDyP8dx+irdH9NlCuU
        j3/KuSmlfiEDXGru76DHVDJDs4JDOmM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-bWC2LJc2PaeVa3PuLtbN4A-1; Thu, 14 Apr 2022 13:22:03 -0400
X-MC-Unique: bWC2LJc2PaeVa3PuLtbN4A-1
Received: by mail-qv1-f69.google.com with SMTP id jx11-20020a0562142b0b00b0044444479dcbso4899160qvb.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 10:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i/2YUxZHXeRUBoBs87Jt7Yv5tGwLCyCxoPCR5L1KNRo=;
        b=VBHvDy8GWBB2FWOPtEAp8FunpyzkrQUVBZbXS55cNH1pJxO3tlfzlhUAkk/vJA+UO6
         ODWD6p9SWeFYGyKfGWgM7d1alU/qBVHvyLpfv9rbNOcElhLvG5SMpE7gsGi15nSaIdwg
         XQg6KGjex2uVD5H0DmJiiH8rC7aDUjrvvXorvPxHADu16/UOw7bkeCkeAn1jCdyXlhB0
         rRwWiarjvtjSelOc0AIZ0V8lIqeKghx9SFuzFrePdgWE5P4YJx9h1txn3fZBlmLBSj8a
         /pkd+r6gMsVVGssD5fb+SVxImUzwfOliPwgjhNPW+FDRH8blPujysYjo1FKIZj78UQG8
         8VSg==
X-Gm-Message-State: AOAM530FogvhbuH0FC+zmNbQSItVjwQUsvCRC6qR67TUmwTLPe+wmC9g
        DwmepxaNPjH5r7J886qjY9JvFDYEUj4doBO5b4CFIuXnhmEvanf4Gj67Pre8mB+2C2QPRhjpDda
        PIWj/VyHnBNwGD2dS60WAo6+j
X-Received: by 2002:ad4:5cca:0:b0:446:77:b7b9 with SMTP id iu10-20020ad45cca000000b004460077b7b9mr11441315qvb.124.1649956923343;
        Thu, 14 Apr 2022 10:22:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcbP7PUfSOKwIHCCFuza3bdqjoIPR1W8UBAPI9RJhgHhZ6h+uJqJ6vTJekn4aE7DlGSkBA5g==
X-Received: by 2002:ad4:5cca:0:b0:446:77:b7b9 with SMTP id iu10-20020ad45cca000000b004460077b7b9mr11441296qvb.124.1649956923101;
        Thu, 14 Apr 2022 10:22:03 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id x19-20020ae9e913000000b0069bf9aedce6sm1220069qkf.29.2022.04.14.10.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 10:22:02 -0700 (PDT)
Date:   Thu, 14 Apr 2022 10:21:59 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 02/18] objtool: Support data symbol printing
Message-ID: <20220414172159.orf3ojiesksqrhsu@treble>
References: <cover.1649891421.git.jpoimboe@redhat.com>
 <097057f88605aa67b0e3ec573fcf394ae7ac4d6f.1649891421.git.jpoimboe@redhat.com>
 <YlfHy011VP2oPFjV@hirez.programming.kicks-ass.net>
 <20220414152148.cwdefx744kymqcut@treble>
 <Ylg+bewBpaqqYgeB@hirez.programming.kicks-ass.net>
 <20220414153854.rqkt465xn4vzndr7@treble>
 <YlhNo026PgjJuCIU@hirez.programming.kicks-ass.net>
 <20220414170100.c66rfyvk7dp33bxx@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220414170100.c66rfyvk7dp33bxx@treble>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 10:01:04AM -0700, Josh Poimboeuf wrote:
> On Thu, Apr 14, 2022 at 06:36:51PM +0200, Peter Zijlstra wrote:
> > On Thu, Apr 14, 2022 at 08:38:54AM -0700, Josh Poimboeuf wrote:
> > 
> > > > Yes, I'd not seen that yet, what's that for? The Changelog alludes to
> > > > something, but I don't think it actually does get used later.
> > > 
> > > Nick had asked for something like that, it's just a way to avoid doing
> > > math every time we look at a warning, i.e. to convert func+offset to
> > > sec+offset.
> > > 
> > > But it's kind of ugly and I'm not 100% happy with it.
> > > 
> > > Maybe it should be behind an option (--sec-offsets)?
> > 
> > Can do I suppose... Myself, I have this script:
> > 
> > $ cat objdump-func.sh
> > #!/bin/bash
> > 
> > OBJ=$1; shift
> > FUNC=$1; shift
> > 
> > objdump -wdr $@ $OBJ | awk "/^\$/ { P=0; } /$FUNC[^>]*>:\$/ { P=1; O=strtonum(\"0x\" \$1); } { if (P) { o=strtonum(\"0x\" \$1); printf(\"%04x \", o-O); print \$0; } }"
> 
> That is nice, just added to my ~/bin.
> 
> And how am I just learning about objdump "-w" ?!?!
> 
> I wrote up a new version of that patch which adds a '--sec-address'
> option (see below), but maybe I'll just drop it for now.  It's not
> really relevant to this set anyway.

But now, testing the IBT code, I realize it would still be helpful for
data addresses.  So maybe I'll keep it.

-- 
Josh

