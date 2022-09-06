Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1C15AF84A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 01:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiIFXNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 19:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiIFXNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 19:13:33 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4C78A1F9
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 16:13:32 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id g14so9237402qto.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 16:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=xnYIwry+S9QmI3kzTAy54hZ+WSydaEv9efoA6mUFDlI=;
        b=YQj0fOnKOsrK0NQh4pwLBz8h4TpbywPIKdXErYOPUxqBdMEnXnrPeSqZcnNVobqqnv
         t3yzOeVg7DLJ2o9eBn2Ujf3Y5kZXVZ5Lie/2Lj+72ENAXlkucIk8p5DQ8Lf4OlLAbQEe
         +P2OYULv6bWTogHvVtQQCQ+ct9rB08VUreDnEjWXTmqHVom9fQgJ7zPbP03oLmyrtz8c
         Ah5oIIXCfPVCoORYzBEx6tVQx2xHzT5Vi/xi4qznam7W0IJOzBblR2buMJpewKOu39Cb
         KT/wcNLGms+zGuqNlmsSuIXP3N1Z/AdJa9UjWKzQqVO++Yv0q0M2jerHvaOg7fkJ2NZu
         7rFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=xnYIwry+S9QmI3kzTAy54hZ+WSydaEv9efoA6mUFDlI=;
        b=GTDxX/r6QCdlwWtVZy4wtPNyYfJ+nSOF+eWDPjwRdtiUEQY4rY4SWAda868E8nc36I
         jirGb8oHd0fAM59rGgxQDkpOKU6nDgX0cLyI7nLs10vi7HvdNuk3HbsbIlEMg/lkvQa/
         y2YLsrDva/DVKJVgYvsRpXa7bbuJiShjUGpograpxZ8RfXgIvo3mpnDJkUEyOPPQt5UA
         9igopGqE/xB+QpJTQRi4Cvn5GWgIEPg9AWU+Shz/1UBCIdQjnE3ZShpRPWqTMYmUExBs
         sJkZKmfDgs8WVO0rsOoZ4CW9QngAJLCZ00/yUMWTapUkZKs9yEfiajbPF06PQUm9LJk8
         UO9g==
X-Gm-Message-State: ACgBeo1G/ZBrqitRUGdPsj+fVZu9omv0/K0la8KTrZoF/7XQ0+nxoWqj
        PSEVke5lbOu2ods+4qZAaAbs9g==
X-Google-Smtp-Source: AA6agR63wRkPOvdwlh1CTNJzoRf8jK43AOJzOEMqgN2OUNkQ/5M16XOHY6bxHK4WQSN0wyioO7n7xg==
X-Received: by 2002:ac8:7f0f:0:b0:344:2fd8:8a66 with SMTP id f15-20020ac87f0f000000b003442fd88a66mr943986qtk.98.1662506011557;
        Tue, 06 Sep 2022 16:13:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id l2-20020ac87242000000b0034455ff76ddsm10530166qtp.34.2022.09.06.16.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 16:13:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1oVhl4-008EPf-0N;
        Tue, 06 Sep 2022 20:13:30 -0300
Date:   Tue, 6 Sep 2022 20:13:29 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     mpenttil@redhat.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        apopple@nvidia.com, jhubbard@nvidia.com, rcampbell@nvidia.com,
        vbabka@suse.cz
Subject: Re: [PATCH v8] mm/hmm/test: use char dev with struct device to get
 device node
Message-ID: <YxfUGRA9q13V3+ja@ziepe.ca>
References: <20220826050631.25771-1-mpenttil@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220826050631.25771-1-mpenttil@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 08:06:31AM +0300, mpenttil@redhat.com wrote:
> From: Mika Penttilä <mpenttil@redhat.com>
> 
> HMM selftests use an in-kernel pseudo device to emulate device
> memory. The pseudo device registers a major device range for two or
> four pseudo device instances. User space has a script that
> reads /proc/devices in order to find the assigned major number,
> and sends that to mknod(1), once for each node.
> 
> Change this to properly use cdev and struct device APIs.
> 
> Delete the /proc/devices parsing from the user-space test script, now
> that it is unnecessary.
> 
> Also, deleted an unused field in struct dmirror_device: devmem.
> 
> Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>

Andrew, this looks OK, can you pick it up?

Thanks,
Jason
