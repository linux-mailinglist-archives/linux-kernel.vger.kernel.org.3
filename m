Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AC551073E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242069AbiDZSlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343969AbiDZSlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:41:01 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4677F6A001
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:37:52 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id kd11so5017560qvb.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vCAdqtcSv+Uuvkd1gfYn6mJK/62p5uI0bhh5S33HH+o=;
        b=hKQNNTwMC0Pg+p4P7tiCPZm0cj9miN42hel47mSzB3H5BqCOYQKy7Zgic6zuztiAgp
         vHNLCSMVT1/3s+QBInq9vSSbcKTFlfOHgP508j701VpKAAWJgcj10GaL/8p4VPFl4tDm
         QwLt+xl51ubmMorzTvwDBSmQvMDAgJfDSrfg1XHY34ECBP4qmpYBZPKRrN8q4na8RHt1
         UyScxb9ei5p4apSOlkbOpxhfSiehS+0Ke9bl9BrT6yKoml5Nl0Oj70D/X/ay8in9Wv/z
         mBdvrmnuSPeFggrdGJ5yQTR269+20YgTk/0BqFZfoLCwJTnSsHlEyTXjCRNOBzjBGkF4
         kPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vCAdqtcSv+Uuvkd1gfYn6mJK/62p5uI0bhh5S33HH+o=;
        b=tTbWvVzTUfz2q3i++F1dYrhnmu6O4HvhaaQXOLspn8kxFBXTG8rFdLQFUiVHAqeT1J
         0T6yvnplSbozigefUgZ7l0CL7UNT249/T7N/1OXrAHpHHzlttihRszhKCDnpYeWMUc1S
         pZxizZOUBWMEHSAPVG6UYGegSK8EX4TcDWemIPGqBecl/CCOnhIkTj2uC/T4DDJ2cljY
         5SY3sWwBngh/mAZkRRHrcYVKXOa0+gayUFEgy2XtYe9zxWePJqfuVzHoxw2vUWRMHGS6
         +pApV1WY+g/Nx1aHTk4oBPFcuVxJsZvCxBaLccU+GBvEHkGmvigfWzcwiLKNRgE7/qgP
         qcLQ==
X-Gm-Message-State: AOAM530oj21i3gd/5lDOOnTkguKOIt7wK1cpNjb581ihrAxwxF+UdnkU
        KW0huShtn2iFjyWvzvpk9Q==
X-Google-Smtp-Source: ABdhPJyiC6wP3gKNyX3AB8SQeHDh5fHSv3C77/OXChNe05LMyjEqMoULU+d8RGd7Dppfigq92I0ycw==
X-Received: by 2002:ad4:576f:0:b0:451:b403:2c3e with SMTP id r15-20020ad4576f000000b00451b4032c3emr16176767qvx.83.1650998272081;
        Tue, 26 Apr 2022 11:37:52 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id x2-20020a379502000000b0069d14dabad6sm6851134qkd.79.2022.04.26.11.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 11:37:51 -0700 (PDT)
Date:   Tue, 26 Apr 2022 14:37:49 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Dave Chinner <dchinner@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH v2 0/7] mm: introduce shrinker debugfs interface
Message-ID: <20220426183749.iumpdardzltpf23y@moria.home.lan>
References: <20220422202644.799732-1-roman.gushchin@linux.dev>
 <YmeK6/eZYaMo2Ltm@rh>
 <Ymggvr4Boc5JIf9j@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ymggvr4Boc5JIf9j@carbon>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 09:41:34AM -0700, Roman Gushchin wrote:
> My plan is to work on convert shrinkers API to bytes and experiment
> with different LRU implementations. I find an ability to easily export
> statistics and other data (which doesn't exist now) via debugfs useful
> (and way more convenient than changing existing tracepoints), as well as
> an ability to trigger scanning of individual shrinkers. If nobody else
> seeing any value here, I'm fine to keep these patches private, no reason
> to argue about the output format then.

I don't think converting the shrinker API to bytes instead of object counts is
such a great idea - that's going to introducing new rounding errors and new
corner cases when we can't free the exact # of bytes requested.

I was thinking along the lines of adding reporting for memory usage in bytes as
either an additional thing the .count_objects reports, or a new callback.
