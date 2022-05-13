Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F96D52617D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 13:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380103AbiEML7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 07:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344951AbiEML7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 07:59:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C2F2285ED8
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 04:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652443151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pt1MSg4G+/JXulhGF1pWl28z2YIqhHl1pzuyEE+yf2E=;
        b=PAe7Zq4o9tsSuURoZoPwxokgR70suJ8FW98o1tS5Yhs9FusetWd9pd8QMbuk35nPJzOy8x
        CuwYaHV0nnU0pAqK3NznU/SnF1GF0yiFoHeYLcefYRJAutQXJ5qTGFkEOCDrB0QbAsGAJb
        WAn5dIJpSePjEQ2xvefy0Los6PSAZSQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-8xlcU9h4Om6MkWIug22SMg-1; Fri, 13 May 2022 07:59:10 -0400
X-MC-Unique: 8xlcU9h4Om6MkWIug22SMg-1
Received: by mail-wm1-f70.google.com with SMTP id i131-20020a1c3b89000000b00393fbb0718bso5884772wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 04:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=Pt1MSg4G+/JXulhGF1pWl28z2YIqhHl1pzuyEE+yf2E=;
        b=7KVj7pBW1D2+G84dLhEjWOUdJdIf4fm9Tz/tUMfJ5h/fC7j9NnOzjwo2wztbTFhcw0
         F8i9wyB8Z+DcqoilZPgXE8we5rZyw3mfz7+zEdk6AnqXeD6tUUZxGdY+B7eUqfgdzuLH
         Y9R7vHOj6SZQrPbCYruIbeeu1AG1GrgL9foaJfQAjG+g1SOMJWZyDaG5+8/UDo/ZBLTg
         /DOSkv8+JGgB4Asr7JZlXF9gZZGO8HuxXte6h0QLau6vkwufF1/PzFXlWT8PYQzXdTf0
         8PO93FA3RAsxtO2U+DS43ByiqUVq+3DFqDIKy0tNAKlg2hNFQgdT7H0t9IqmFuWHEKsm
         EVNg==
X-Gm-Message-State: AOAM533k40C3IhCNQvkVp/txyMH2GDJ8fYK8ODt++aVgzwMR9G/V0XoI
        HTT/C/zzEX2cHQiccp+grU07dkyTupO5qPqr7hbmup7LeEsZzNo3jUT5XQhAlfO6rzU4AAKn+1i
        z08UTjHTTbz3u1mQalUaTh+Wu
X-Received: by 2002:adf:cd08:0:b0:20a:eafa:4103 with SMTP id w8-20020adfcd08000000b0020aeafa4103mr3728075wrm.227.1652443149331;
        Fri, 13 May 2022 04:59:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDUUlG0HhOoqg75mnUCd8WqeCa+JGn09IHsozpwXt7ZY82mUimtgcOA5qaPatrIGrbqDFo4Q==
X-Received: by 2002:adf:cd08:0:b0:20a:eafa:4103 with SMTP id w8-20020adfcd08000000b0020aeafa4103mr3728058wrm.227.1652443149144;
        Fri, 13 May 2022 04:59:09 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:1306:2f00:be0e:91f7:c0a3:32f0? ([2a0c:5a80:1306:2f00:be0e:91f7:c0a3:32f0])
        by smtp.gmail.com with ESMTPSA id q20-20020a1ce914000000b003942a244f3dsm5157732wmc.22.2022.05.13.04.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 04:59:08 -0700 (PDT)
Message-ID: <b6b57e7efd8de808de12fdc60fe88ae3b264b74d.camel@redhat.com>
Subject: Re: [PATCH 1/6] mm/page_alloc: Add page->buddy_list and
 page->pcp_list
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Date:   Fri, 13 May 2022 13:59:08 +0200
In-Reply-To: <20220512085043.5234-2-mgorman@techsingularity.net>
References: <20220512085043.5234-1-mgorman@techsingularity.net>
         <20220512085043.5234-2-mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-05-12 at 09:50 +0100, Mel Gorman wrote:
> The page allocator uses page->lru for storing pages on either buddy
> or
> PCP lists. Create page->buddy_list and page->pcp_list as a union with
> page->lru. This is simply to clarify what type of list a page is on
> in the page allocator.
>=20
> No functional change intended.
>=20
> [minchan: Fix page lru fields in macros]
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> Tested-by: Minchan Kim <minchan@kernel.org>
> Acked-by: Minchan Kim <minchan@kernel.org>
> ---

Reviewed-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

Thanks,

--=20
Nicol=C3=A1s S=C3=A1enz

