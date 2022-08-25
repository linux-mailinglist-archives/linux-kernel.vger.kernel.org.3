Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3620E5A1577
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 17:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239876AbiHYPTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 11:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbiHYPTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 11:19:51 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2377332A8F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 08:19:49 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id u9so11217023ejy.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 08:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=rUvL/+byhm9aX0IoB++4OAREur0xLEPwmq4mJRFHNjc=;
        b=wY8Q+FVjX2xxTtU/xPWdr4joxoRR83qdgwwS3pw3GuVR4PK0CxM/ugqidKl9B3X0FD
         UsFNKAN8ekHQxOq4eK/ial4UP2fbJI3EALOcAPJmvFbPWXZhiqcysnBvmeN+NVLkNTwJ
         8q3HTjizgvw/d0VTfVfFi+GxHGd60G9ZuoQi7dzY3Jifuk/Mms39iXRiczCoADST4znr
         DbBOxBVuNCROJnjNC46vkC1F14q0QIYoiXl1G1YAonGCy7pmv1gP5p0JBzGaIGYy6gfA
         iQHnAtwHXs7J9GQ9aorOAm1ip7At2LCPV2c+W7RWeSmPVDPyedwDGA4tWbAJ4smJjLrQ
         sJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=rUvL/+byhm9aX0IoB++4OAREur0xLEPwmq4mJRFHNjc=;
        b=27nzyIkFyhS/ifTkxLbjqm6tkyRQmM3umcjCiTVaEfyHD7aJaUCNM8jHc0E5/fWb96
         n7L5dggpVxsNi+ddwFcI5fnbpcz9D3TzoS6QEWlYbMNLLQhotqjVjYorC7xNJLKJeD+u
         iMmgazTnZ9Y7/0R3iY4uNe22VjQ+dxnwTdnssWvt4o9t8R4B1ZEnbwRLnd4nyKpYosFu
         cxKUSVT2ROMG4iUC/11ltD0O4HCuvk/mzkswflA3YMkd3dtLkoNDV9M6th+AH/vYTddZ
         QVPDwKN2VaMWEFIHOhR/G2bj2StBtiI1cEMxUFccP+N+MtwaWapLE+Uok1cT0wW0UMcL
         E1iQ==
X-Gm-Message-State: ACgBeo1X/tJLPi5gGdP6AdVGcXw/l6R/zgH2kYsBWVOKFywGFezpHQaV
        lkpZaEfKYHuQIj9lKb1oAOmpaA==
X-Google-Smtp-Source: AA6agR6a90sENW/c5DSyaYDY85E3bwabjpXstRpLC21buvEiy+L9HE9ZewDrX8jgt6an16mF+yfI8g==
X-Received: by 2002:a17:907:868b:b0:73d:83c3:2bf with SMTP id qa11-20020a170907868b00b0073d83c302bfmr2857695ejc.747.1661440787724;
        Thu, 25 Aug 2022 08:19:47 -0700 (PDT)
Received: from localhost ([2a02:8070:6389:a4c0:2ca9:6d59:782b:fff3])
        by smtp.gmail.com with ESMTPSA id la18-20020a170907781200b0073de0506745sm19486ejc.197.2022.08.25.08.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 08:19:47 -0700 (PDT)
Date:   Thu, 25 Aug 2022 11:19:46 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm: reduce noise in show_mem for lowmem allocations
Message-ID: <YweTEpvgi7/QviYt@cmpxchg.org>
References: <YwScVmVofIZkopkF@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwScVmVofIZkopkF@dhcp22.suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 11:22:30AM +0200, Michal Hocko wrote:
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
