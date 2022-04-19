Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01925072B5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354408AbiDSQL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbiDSQLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:11:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21ECA1FCF7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 09:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650384552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QjO9zZCHyHzmC89BeesJw6bj4mjc3AQKTs5k6ZcDG5Q=;
        b=QsFsg4zgiCJfIoGiIvU4oWs5c3FQw1Wup+Y23qU8O8QsLZPkr49FLhrPIZrG7doeMDRxHu
        d+hrg9wqYUW6c+Tx5GZpC5gERXcaIfUaQt7qYIYXu1NhXTwzR4Q2QKvFdsx1wBBpINJilj
        hyxJgejtbjKJWf4wBFEIMZsvLD31bw8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-T7adfZiMNrGmlZeWpkZ84w-1; Tue, 19 Apr 2022 12:09:05 -0400
X-MC-Unique: T7adfZiMNrGmlZeWpkZ84w-1
Received: by mail-qk1-f198.google.com with SMTP id v14-20020a05620a0f0e00b00699f4ea852cso12766195qkl.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 09:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QjO9zZCHyHzmC89BeesJw6bj4mjc3AQKTs5k6ZcDG5Q=;
        b=ZgeEwpZ66bB5iydWK34Z5ngnQ5O6SznC78gigmhqTtld/TpQTGOxIvafJrUgeeb9pw
         uJuLUx0Z2MQu7MDgOf59WCH6KwcwApIgPWaVAPqKle6Nk1FKh4YfU66Yjkv4iHelPfh0
         cSSxS4YB0jgB/zrzJsF1irIPdnkl6WQBRLKnyFR0fOCJQrG8C+ZCUCgQz7IomNJRw7EN
         v7irjI1ydjGxCpeVsOMqA3E/NYWukBLhM/WwkAwCc/uYUNNnS4iQi1PT7uK10+/cHBdZ
         uP1EBIz/SwfTmlm6vMrkJI/SOyXqsyrE1p4Fj+3yZEmdw+TAm+N3t79kWBZKWXCMCkhn
         wuaA==
X-Gm-Message-State: AOAM533dXCxydOdFnD1nSB2DxgS6+cuvQaKOdTEMQHYRjgd885Uqwyr1
        DHaDfx+N0nQVTEU9Mg9vQjSh+iOP2CbTjDcu71kq8Pegsy9338+J/Kdl0qphyN5HBiDJI/GHWhI
        vPdsRAyq8EIMrNtG3eRIDJQoC
X-Received: by 2002:a05:620a:25cf:b0:699:bbc6:9e58 with SMTP id y15-20020a05620a25cf00b00699bbc69e58mr10316583qko.64.1650384543639;
        Tue, 19 Apr 2022 09:09:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8dlQKXYLkLZqpht+RsMtbyTiQevbAbgNRNLox9DzH3ZmLhYrpq2QEWFF4oUpzdt/NutnGVA==
X-Received: by 2002:a05:620a:25cf:b0:699:bbc6:9e58 with SMTP id y15-20020a05620a25cf00b00699bbc69e58mr10316560qko.64.1650384543400;
        Tue, 19 Apr 2022 09:09:03 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id c20-20020a05622a059400b002e1d59e68f3sm244823qtb.48.2022.04.19.09.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 09:09:02 -0700 (PDT)
Date:   Tue, 19 Apr 2022 09:09:00 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v2 13/25] scripts: Create objdump-func helper script
Message-ID: <20220419160900.2clkkvpit7zyu2o6@treble>
References: <cover.1650300597.git.jpoimboe@redhat.com>
 <ab37c23d28a8b9cf7a6707cc5af5e1aef80ba4a3.1650300597.git.jpoimboe@redhat.com>
 <20220419111555.GR2731@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220419111555.GR2731@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 01:15:55PM +0200, Peter Zijlstra wrote:
> On Mon, Apr 18, 2022 at 09:50:32AM -0700, Josh Poimboeuf wrote:
> > Add a simple script which disassembles a single function from an object
> > file.  Comes in handy for objtool warnings and kernel stack traces.
> > 
> > Originally-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > ---
> >  scripts/objdump-func | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >  create mode 100755 scripts/objdump-func
> > 
> > diff --git a/scripts/objdump-func b/scripts/objdump-func
> > new file mode 100755
> > index 000000000000..140646c456fc
> > --- /dev/null
> > +++ b/scripts/objdump-func
> > @@ -0,0 +1,18 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Disassemble a single function.
> > +#
> > +# usage: objdump-func <file> <func>
> > +
> > +set -o errexit
> > +set -o nounset
> > +
> > +OBJDUMP="${CROSS_COMPILE:-}objdump"
> > +
> > +command -v awk >/dev/null 2>&1 || die "awk isn't installed"
> > +
> > +OBJ=$1; shift
> > +FUNC=$1; shift
> > +
> > +${OBJDUMP} -wdr $@ $OBJ | awk "/^\$/ { P=0; } /$FUNC[^>]*>:\$/ { P=1; O=strtonum(\"0x\" \$1); } { if (P) { o=strtonum(\"0x\" \$1); printf(\"%04x \", o-O); print \$0; } }"
> > -- 
> > 2.34.1
> > 
> 
> This might rely on awk being gawk, I'm never very careful about those
> things.

True, running with --posix I get

  awk: cmd. line:1: (FILENAME=- FNR=17142) fatal: function `strtonum' not defined

The non-gawk users always ruin the party.

-- 
Josh

