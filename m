Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FA34BF471
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiBVJOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiBVJOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:14:43 -0500
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE378C7FB;
        Tue, 22 Feb 2022 01:14:19 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id p14so40735648ejf.11;
        Tue, 22 Feb 2022 01:14:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FPiFUHz8gL0RsYyZ6HOzzlInU1l+QGgn3EWierA/h04=;
        b=gXcozFee1nVH7PzWChBXHd4yuyk2MpVK/zgcvXU1EixlnGlU1h8ZNZe1F55jkpAntW
         E+MJFEd/k/mukeSmKxODr6w/V5bUyTvI5+1r4pgIs1V9qy5MV/RIjcl9D6F03t9/NV3+
         j8shcv5VjBfQVH9iQsCmN55uSgaFxe9kaItdm0g1fYg4jMcgNFb5TDGvGC8w1fes6YxC
         j841M+W2tCNHrvgupMZt7lAbrRyQqWK2Q0q5oNtGKRxEpkitVI10oaYoExhRi89PWeYj
         qUeWf1Sx0kw9QbeQ3Bc7xgsMCSFQOMFfF42zkOUrZlFLid/QzjpmfYvCzeu/Npb2VQDW
         3Qcg==
X-Gm-Message-State: AOAM532VjxJqhJdKMxF4pFsY8+sSVm55asvHPkBD5c1TPOsG+hkgkW9C
        4awXsmdTFlQDlqkbp2CPioz03KzKA6k=
X-Google-Smtp-Source: ABdhPJzM1nPTLCViA0CLafXS4qeAXx1Pq8KlOXsF+XoQ12GLi26h0QIIyUa4btfMeNQ93r+m6RoPzQ==
X-Received: by 2002:a17:906:3905:b0:6cf:7ef5:fee0 with SMTP id f5-20020a170906390500b006cf7ef5fee0mr18180817eje.307.1645521257554;
        Tue, 22 Feb 2022 01:14:17 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id r3sm6123780ejd.129.2022.02.22.01.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 01:14:17 -0800 (PST)
Message-ID: <d8336f83-9f31-e168-1ed7-29e97189e233@kernel.org>
Date:   Tue, 22 Feb 2022 10:14:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 2/2] serial: 8250_lpss: Switch to pcim_iomap() instead
 of pci_ioremap_bar()
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20220215134359.78169-1-andriy.shevchenko@linux.intel.com>
 <20220215134359.78169-2-andriy.shevchenko@linux.intel.com>
 <Ygy7dNqFLZF9XYiH@infradead.org>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <Ygy7dNqFLZF9XYiH@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16. 02. 22, 9:53, Christoph Hellwig wrote:
> On Tue, Feb 15, 2022 at 03:43:59PM +0200, Andy Shevchenko wrote:
>> The pci_iounmap() doesn't cover all the cases where resource should
>> be unmapped. Instead of spreading it more, replace the pci_ioremap_bar()
>> with pcim_iomap() which uses managed resource approach.
> 
> pcim_iomap requires the use of ioreadX/iowriteX and thus runtime
> overhead.  So in doubt please add a pcim_ioremap_bar instead of forcing
> the legacy iomap/ioread/iowrite API onto modern drivers tht can't
> support legacy port I/O.

Hmm, the driver combines pci_ioremap_bar with pci_iounmap. pci_iounmap 
does the right thing after all, but is that correct? And this driver is 
not alone, this shows more:
git grep -E 'pci_iounmap|pci_ioremap_bar' `git grep -l pci_iounmap \`git 
grep -l pci_ioremap_bar\``

-- 
js
suse labs
