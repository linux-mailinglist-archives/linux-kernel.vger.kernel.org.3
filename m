Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E75D495696
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 00:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378146AbiATXJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 18:09:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52399 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378148AbiATXJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 18:09:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642720177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3DFeZ1TFp34Pl+W08J0c/5GgqOIQHrN13brjYVbP1e8=;
        b=OFpRNjB6PqKcxiZBCc8299IhTbAresiCEhoE8AuTBeKGnmBu8VPOF1tUWR/T+e7w+FFmGL
        cu6dDg26EjUjrQD9nDfMO6GRUOyBLnBTJd3B7bGynLQWLF0jT/RDHBQzc7OIhQSMm1TSUR
        JWSAKASvEuoVt7OEbVUOIVKLUUIpbPo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-idS8GwgGM3-4wi_zjQI8BQ-1; Thu, 20 Jan 2022 18:09:36 -0500
X-MC-Unique: idS8GwgGM3-4wi_zjQI8BQ-1
Received: by mail-qt1-f197.google.com with SMTP id bq17-20020a05622a1c1100b002cae8cc2d38so5169219qtb.20
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 15:09:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3DFeZ1TFp34Pl+W08J0c/5GgqOIQHrN13brjYVbP1e8=;
        b=siaYebt9LGzCzdJFwNwt52/mBoR6pxmAnIXGBv8BGulMI3H8J1kvxQGvLYyAb80tSr
         QKoKT2LqUl7DMUswVevDFCFq75ubG6tCEKn9Gm5/fN2JPXSuYwmwFnBEXDBW+TLyjpew
         FZZAHF2Ptm1oEQczvlTSKw/Npuscl20gJMZ35TeWs0uv40NFanQMM0fXcngT3dxPDg+W
         DfSoQG9q/4sfu1qHRi47LK9Hso3wtrs1UbIiPcclBBR/+8fVy+ugU09q4GpjC5gSVP6d
         0Ku7Fu23GEdPpfCXocDYRwvjun7P5biV0RRPiIthsVuN7NMDkx9pFBn8WcJUwRhilJJV
         qlDQ==
X-Gm-Message-State: AOAM533rpRzq559qI+LSLOzLdkaPxINTBiWyzsdbLBFnh/3C9afAD9Bz
        yvUENr2wKSU8g6WSNj2NZ+Bc43KcqWFcUWHIRIppeGA8YiAwFzKfARpc3T6/4at6k46qmGk//sZ
        zL1HlcV0bBGcRO4bb6Kg+M+OP
X-Received: by 2002:a05:620a:4401:: with SMTP id v1mr935774qkp.402.1642720175782;
        Thu, 20 Jan 2022 15:09:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxJO3KsyktKOOJzCdW6z9OOEzp62/IjkWvQKZ7qVmAO7CGL6HrtVV+Fl76EhRCePzv9ptRMcA==
X-Received: by 2002:a05:620a:4401:: with SMTP id v1mr935755qkp.402.1642720175564;
        Thu, 20 Jan 2022 15:09:35 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::c])
        by smtp.gmail.com with ESMTPSA id i4sm2418596qkn.23.2022.01.20.15.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 15:09:34 -0800 (PST)
Date:   Thu, 20 Jan 2022 15:09:32 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: check: give big enough buffer for pv_ops
Message-ID: <20220120230932.vgd3sj4yuk7mhmno@treble>
References: <20220114075756.838243-1-slyich@gmail.com>
 <YeE588tXLrgWoUu4@hirez.programming.kicks-ass.net>
 <20220120225810.zqpbug6oj52c34cg@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220120225810.zqpbug6oj52c34cg@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 02:58:13PM -0800, Josh Poimboeuf wrote:
> On Fri, Jan 14, 2022 at 09:53:07AM +0100, Peter Zijlstra wrote:
> > On Fri, Jan 14, 2022 at 07:57:56AM +0000, Sergei Trofimovich wrote:
> > > On gcc-12 build fails flagging possible buffer overflow:
> > > 
> > >     check.c: In function 'validate_call':
> > >     check.c:2865:58: error: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 9 [-Werror=format-truncation=]
> > >      2865 |                 snprintf(pvname, sizeof(pvname), "pv_ops[%d]", idx);
> > >           |                                                          ^~
> > > 
> > > I think it's a valid warning:
> > > 
> > >     static char pvname[16];
> > >     int idx;
> > >     ...
> > >     idx = (rel->addend / sizeof(void *));
> > >     snprintf(pvname, sizeof(pvname), "pv_ops[%d]", idx);
> > > 
> > > we have only 7 chars for %d while it could take up to 9.
> > 
> > Right, very unlikely to have that many pv_ops, but it doesn't hurt to
> > fix this.
> > 
> > Thanks!
> 
> Alternatively, 'idx' could just be unsigned char, since pv_ops only has
> about ~80 entries max, but either way works for me.  I'll queue it up.

Sergei, can you send a v2 with a valid Signed-off-by tag?

-- 
Josh

