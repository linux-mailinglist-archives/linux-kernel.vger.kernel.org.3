Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12A84F5241
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1849863AbiDFCk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1575698AbiDEXIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 19:08:46 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AF7275CA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 14:40:18 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id b15so682429pfm.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 14:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=0JTmX/lC0hG9yq+jd3ONDrgjwpA6pJb9bWxC7NEbBEw=;
        b=WJEsMa2YFI+12uk4elHbe+wsu8NzrGPbtKk/cMhmPnEIxBfwWCE5xYcFcCp3XDF5iP
         CN0mXiNKtbHN9tg+e23UzyOXo6b2QeWp6Ipx81aUbVYBwWd4kCVr07/ZSDSGjuRUJJ8a
         kFAUQXmhTozJihzSfUVy8kpGM7tjoXuET30ufEoo64WSNW3XTRcj2y8tZVGeI9/beoy/
         zh7gATThbEx6K53xd68hBPQFFEVXbhToF8BWa1jzSOhogTHJgynuUr82tFkfN0Dw6SN2
         BNjtlX687++xrsB0EOFJdorTkm+VU9hKyp1c07hex6mxFw8d1ZtO5nbMumLeC1GrO7dn
         Lp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=0JTmX/lC0hG9yq+jd3ONDrgjwpA6pJb9bWxC7NEbBEw=;
        b=TSFY4y7rPI9naF5C9PEP0omjLUixypUI//WOi1jHeZB3IR8aPbfA21Yan3r56jcGXR
         z2ru1iyPNtNxwumbV/GnIOlkmHhepecwH/NJhAEgUWNsqhJuE2KqdHVY2VnIDiNe2N+v
         ZFDv+clhRUBRKNDpmunebyuFpTPhMHgIKhcXp5ipz6zHr2xYFRDZ6ngsBOAntuFmmKeb
         k/efrxkLBUs3OvVaX6iuG7/tNkfOPuS67+UL4+SVJ9aaDll0PeKyTYhPjxPFZLKDna3n
         RpO2G3JeUChwYf990Cv+UmUi1Bg23SFv14V2KS2CQKc0E8GWUgBKApeoeJt/+k9Y9W+K
         oz8g==
X-Gm-Message-State: AOAM532ubOAIslzaadNEmVGeqIMU9aWxEHFDmCi3YlTai7TmebLh/lIg
        95/ifayt8eNphjbRZdD4r7s+Gw==
X-Google-Smtp-Source: ABdhPJy5Pc2RZGWeq2zUSGslDcJEcOIWw3o6pAwyA9f0e/LD+reoFIt9Mx5IXFPevLffUC7Afoj2ZA==
X-Received: by 2002:a63:af10:0:b0:398:91:657 with SMTP id w16-20020a63af10000000b0039800910657mr4452112pge.413.1649194808849;
        Tue, 05 Apr 2022 14:40:08 -0700 (PDT)
Received: from [2620:15c:29:204:be3e:5e1c:99cc:513f] ([2620:15c:29:204:be3e:5e1c:99cc:513f])
        by smtp.gmail.com with ESMTPSA id c4-20020a17090a4d0400b001ca5cf3271csm3538893pjg.14.2022.04.05.14.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 14:40:08 -0700 (PDT)
Date:   Tue, 5 Apr 2022 14:40:07 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Marco Elver <elver@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Imran Khan <imran.f.khan@oracle.com>
Subject: Re: [PATCH v3 2/6] mm/slub: move struct track init out of
 set_track()
In-Reply-To: <20220404164112.18372-3-vbabka@suse.cz>
Message-ID: <18ede94f-818a-d4f2-14e7-d73fdcd78eb5@google.com>
References: <20220404164112.18372-1-vbabka@suse.cz> <20220404164112.18372-3-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Apr 2022, Vlastimil Babka wrote:

> set_track() either zeroes out the struct track or fills it, depending on
> the addr parameter. This is unnecessary as there's only one place that
> calls it for the initialization - init_tracking(). We can simply do the
> zeroing there, with a single memset() that covers both TRACK_ALLOC and
> TRACK_FREE as they are adjacent.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-and-tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Acked-by: David Rientjes <rientjes@google.com>
