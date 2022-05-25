Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590A0533BEC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 13:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242981AbiEYLok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 07:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242936AbiEYLoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 07:44:38 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCE8A204F
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 04:44:36 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id s68so2396030pgs.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 04:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nCNfEzGqMIoFCilTHapRIVeS9mBRmJZJ0gWnXehqDrw=;
        b=KKorYnAd9m8FFqkZWn1KRNBoG7l7TplARvR9C9P62KHQROZ+jCx3jrm3pqL/gal3c9
         tFxlYeVI5en3DpBcz9uCwkckr9YIthe+s0N26u6nJlmW2jp2woFwMCKEv8tbOJ6Ue3TI
         WbS9a4byWlYC8V9D8SCd2meKPqDE/U0FTn5968T/hQciYJlyiEq9tZ94pXPADWkvFk0j
         eBCLDxzMmIeDgmSoxpS+Db6wfsGf6U2Vh4SNWSSt6qCjruPdllqx+6OFrhWa3ZcNnszL
         b/ePL8Ohf4qX+HlckCZ2au3uCxyAFMSgsiIR8AcKFf1o7nK3X+9eTEmBH7FOmpCbJ/vp
         WKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nCNfEzGqMIoFCilTHapRIVeS9mBRmJZJ0gWnXehqDrw=;
        b=nwSbq9ePTqdumSStETveLbTsFt0MBwLtoGSpcVvjYqxYPfwW563YR7tcnQEhJoFe9S
         YqjzT53IINEXiRNGYv/xHu0TxhnrVqYLgnsXUi5s76BT2DILW8iIyJ+YHexz+2dwYHqK
         f2T4kztXWuw04dVC3O8Rvuak1BJMxU6KsS6XCI5oeVYpab4Fu2HWVFgdUGVlZggh+0Sa
         N6rh+sfntHqE+duAJO7xXqjtbvvCZA0/KYubfn4qL6Wu+wCZ2hh24P1AK8+T7F4/IAoR
         dom8P2SjhVxY/LMlUx3xNQHOgUGU0a1+E9fPTSWEX+dLYtix64QKNsxZ2BaqColpb+LP
         vu5g==
X-Gm-Message-State: AOAM530/R4G30MPvHIODX938MhDgr/CjNrHTLk2BKVCyRU4IzoTsicmD
        cEOsX7ws8V7W9Ot8BacqynAjXA==
X-Google-Smtp-Source: ABdhPJwECqnEoVXXBBz8+x+EnBqP+BiRhIpyeDXKNS2lypsKKNocA6JT73IkkBBWb0ZU66Vx2+IUag==
X-Received: by 2002:a05:6a00:2353:b0:518:96b7:ceb8 with SMTP id j19-20020a056a00235300b0051896b7ceb8mr16934713pfj.5.1653479076348;
        Wed, 25 May 2022 04:44:36 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:c40f:7b5:4fa8:df3f])
        by smtp.gmail.com with ESMTPSA id u22-20020a17090ae01600b001df666ebddesm1406580pjy.6.2022.05.25.04.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 04:44:36 -0700 (PDT)
Date:   Wed, 25 May 2022 19:44:31 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com
Subject: Re: [PATCH v4 06/11] mm: thp: make split queue lock safe when LRU
 pages are reparented
Message-ID: <Yo4Wn7IBdNBR8dWx@FVFYT0MHHV2J.usts.net>
References: <20220524060551.80037-1-songmuchun@bytedance.com>
 <20220524060551.80037-7-songmuchun@bytedance.com>
 <Yo2aa661fepAOvjO@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo2aa661fepAOvjO@carbon>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 07:54:35PM -0700, Roman Gushchin wrote:
> On Tue, May 24, 2022 at 02:05:46PM +0800, Muchun Song wrote:
> > Similar to the lruvec lock, we use the same approach to make the split
> > queue lock safe when LRU pages are reparented.
> > 
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> 
> Please, merge this into the previous patch (like Johannes asked
> for the lruvec counterpart).
>

Will do in v5.
 
> And add:
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev> .
>

Thanks Roman.

