Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3FFB4841C8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 13:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbiADMoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 07:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbiADMoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 07:44:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9FEC061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 04:44:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE0C3B8123D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 12:44:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1DCBC36AE7;
        Tue,  4 Jan 2022 12:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641300256;
        bh=2a7QZW9xS69GfqXcY08GEr4GrelI5J/qIXoo9JFkako=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=l0yP4JUI/V+aeqv1R3FEE5iZP6Co9PKXAuimnD0yIwK9MOvcBniiovvKdBCNoz6KZ
         4D57MPGgKr0/gf2WrI36N+hvz9ROu4RsnKfOuXgsuaIaHceLxuNZ67c+M+ni3oMBjq
         SOF2WOguhxG6pN8i3Y0NEXZ7gJPX0SE0Vnh+ZwANbeskXVxqYokOlgxFI6dzC5JpJ8
         YLbLHM7N6N5u2xY/NE5KYXBHo+L25Ioj5CQUxXqaUhsyzYE88fYVHthyS7mqSeB5p0
         kkq3Q+crMWYnw1ASRkWxxcs35HvvAiLzfr8Om/UaoqnaEY6WD7z++16T2Yn8A+QB+S
         eWWEayQZrN0Nw==
Message-ID: <22e4925b-5e85-141a-1e59-c140d35af0be@kernel.org>
Date:   Tue, 4 Jan 2022 20:44:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 5/5] erofs: use meta buffers for zmap operations
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Liu Bo <bo.liu@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>, Yue Hu <huyue2@yulong.com>
References: <20220102040017.51352-1-hsiangkao@linux.alibaba.com>
 <20220102040017.51352-6-hsiangkao@linux.alibaba.com>
 <5ed798da-4f01-17d4-cba2-dda50728bd25@kernel.org>
 <YdQNCJzQULVxC2QC@B-P7TQMD6M-0146.local>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <YdQNCJzQULVxC2QC@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/1/4 17:02, Gao Xiang wrote:
> Thanks for the question. Previously, erofs_get_meta_page was called
> independently without reusing zmap mpage, so the page refcount had no
> relationship with zmap mpage.
> 
> However, now we reuse zmap metabuf instead(fe->map.buf), so an extra
> page refcount is needed since zmap metabuf will be released at the end
> of readpage or readahead...

Thanks for the explanation.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
