Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7431A472035
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 06:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbhLMFCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 00:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbhLMFCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 00:02:50 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A360C06173F;
        Sun, 12 Dec 2021 21:02:50 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id v23so10997195pjr.5;
        Sun, 12 Dec 2021 21:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PKsKSjxqNb+wfoS23yK+YBdcKb7YgyYHFw7IzVI0ZEk=;
        b=HsFhTamPiqukqZGR017NAEw6TUmQf2tG0rseMVBiY0ZZ6ckQfNgPtysKllVYu/P/23
         Ws+yYfQ8TPRwDte3ixYGLWxa9ja0/CJORwlomGsaCZLstuPt/TENb4U1T6BXqdQ/jiV8
         5N5iW20TBPCeYP9m7Kb5DP8nilJvuLYR03DdOk82QBnSLybzN1qNIPo6/8i41asfNgmz
         EQt4oMCe1ZXR67F9JgOc5CiWs1MyHkCM7cpa9F9geB4EtTKwIWqgSbLShEzXDgQI8ZND
         Qp19AgkzLBY6NNc3v+d1puOWdD+lNE1TkXTDNSmGH6gz23L+fBFPvXOaPW030hT72/hJ
         tRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PKsKSjxqNb+wfoS23yK+YBdcKb7YgyYHFw7IzVI0ZEk=;
        b=x1ReQW6pbV6Ojf5BmXAfZdfk4zVNYgGPUXPlcj2jx0X/C8OS6wH0pXFivskFXCn7VY
         xsZr3bAURPNP7rv42fAaIDoz9BTekkwa9eReOC6X3Screu+kKMAdMg1wLIRrrGM84Oo8
         1y4Fpc8/7d2B1m6IsROSLan8JXKIxI9BmEtPYRTz2OL2r9vo1y9qkeqzwqQt/UMIgiNl
         GhopJiEAPSbJl5+2cQ46/cF5QseB+2sIa0xGrzACuBDsWChjlZo9zirurYDDWS6aCOty
         nn8RY2+vxfJwh1J9v4wcrws2oWW3BFrBu4kxIIj9De/rDKKgWK9a0lDCtPD4glWikWgx
         lv1A==
X-Gm-Message-State: AOAM533YS5k35/JniOIL27C0TKLg68R1PqzD5Db154Fkzhj3VkNxux2J
        N2O/h/uc4zQycuLSCVd541qdAdU8Rpc=
X-Google-Smtp-Source: ABdhPJwOI+1dDFGM9saqkBprZVmh3HbF4aGEL3U8UumR6qUqH+U+5hJFEqmVfeEdApUBayyhqPKyYw==
X-Received: by 2002:a17:902:eec5:b0:143:982a:85c with SMTP id h5-20020a170902eec500b00143982a085cmr92514169plb.66.1639371769448;
        Sun, 12 Dec 2021 21:02:49 -0800 (PST)
Received: from google.com ([2620:15c:202:201:e537:8856:7d40:7c6])
        by smtp.gmail.com with ESMTPSA id p10sm10542891pff.173.2021.12.12.21.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 21:02:48 -0800 (PST)
Date:   Sun, 12 Dec 2021 21:02:45 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc:     nick@shmanahar.org, rydberg@bitmath.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: atmel_mxt_ts - fix double free in
 mxt_read_info_block
Message-ID: <YbbT9fXEk3rMwF6Q@google.com>
References: <20211212194257.68879-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211212194257.68879-1-jose.exposito89@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2021 at 08:42:57PM +0100, José Expósito wrote:
> The "id_buf" buffer is stored in "data->raw_info_block" and freed by
> "mxt_free_object_table" in case of error.
> 
> Return instead of jumping to avoid a double free.
> 
> Addresses-Coverity-ID: 1474582 ("Double free")
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>

Applied, thank you.

-- 
Dmitry
