Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF3B507EB8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 04:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358877AbiDTCSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 22:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiDTCSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:18:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0852215A39
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 19:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650420966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WeWR3XuRtCV+SmnQ0j5vbT57cYudBfkDBtTnd1vmbQ0=;
        b=By0DsteslAX5pRCtsXKGXe3MCKCkREFGmrtC+XpjGXqvqiWyq7naWGEFrqX8mC8vf+eajs
        4UAcywxAAGH5FQeLKC8v+xCobvC7nbtf9PWgPF3Aybn9kvRryW1F78KWJ5hQ6HZsC7IHo3
        7zdNbPp1RkhbOMDGEGRPb5cmMY2iCRo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-fzWxGiDyPpuPiePQR4bpKQ-1; Tue, 19 Apr 2022 22:16:05 -0400
X-MC-Unique: fzWxGiDyPpuPiePQR4bpKQ-1
Received: by mail-qk1-f199.google.com with SMTP id ay14-20020a05620a178e00b0069a9c319c64so291253qkb.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 19:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WeWR3XuRtCV+SmnQ0j5vbT57cYudBfkDBtTnd1vmbQ0=;
        b=4o+Va66PpiCU0euXqs+l1eXfATknv0M8vEimcRkKMldVzthO3PkE2UfwOeb0khoRgr
         0OrpP2X9B27MCUGazaGwR83mssYYTbKhVx+d+gc0EIki9piLEhk+Ra880B2cg9p2/F3n
         N0GBWO5YjXzLTcLP7CLXGlJ/VDw9Trpz07HipPvhAyW9B/hkxFO+PSdBE5z59NjTpGG0
         Sx85lP5lGrmy0KAZlda+aGeUbhPsduIJwZTcsBNbizLFf/4lVOhP6FerKpAEP16RIlat
         8jDZMRrAV4c7ftWoE/qCUPnuRVNmChdqKQ3Vz042dwTJUqrxXZx9T9U/Jj9brigGDiba
         bbHw==
X-Gm-Message-State: AOAM530B8oFIINgOcCjj0nXgXXl9a6QSEiSupRBdl3xyDpE50Z/WRiXf
        dOvEejainu5y/2Tfpfs7VLJ5WTkPGyxX+cC1HoFJ4k7CdnICrV2vp3wUUvnRvJnJcchWesoVBHM
        LY890q4AYy5fpHbSWK0hNTRTM
X-Received: by 2002:a05:622a:610a:b0:2f1:d998:319b with SMTP id hg10-20020a05622a610a00b002f1d998319bmr12355278qtb.478.1650420965154;
        Tue, 19 Apr 2022 19:16:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNF08kJey/nZHLAoEzUc1glCXv/MzFYlP6AafwehMWYz8RHKIFqAFVUkulmOySqWD67hcEhA==
X-Received: by 2002:a05:622a:610a:b0:2f1:d998:319b with SMTP id hg10-20020a05622a610a00b002f1d998319bmr12355265qtb.478.1650420964845;
        Tue, 19 Apr 2022 19:16:04 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id p5-20020ae9f305000000b0069e6dcc4188sm871227qkg.57.2022.04.19.19.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 19:16:04 -0700 (PDT)
Date:   Tue, 19 Apr 2022 19:16:01 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH 2/2] objtool: Fix code relocs vs weak symbols
Message-ID: <20220420021601.kiughdji3avh2uua@treble>
References: <20220419203254.034493341@infradead.org>
 <20220419203807.655552918@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220419203807.655552918@infradead.org>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 10:32:56PM +0200, Peter Zijlstra wrote:
> +	/* XXX create ? */
> +	if (symtab_shndx) {

Not sure what this comment means?

Otherwise both patches look good to me.  Let me run it through some
tests.

-- 
Josh

