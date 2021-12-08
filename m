Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABCE046D4BE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbhLHNvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 08:51:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53615 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231571AbhLHNvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:51:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638971261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WgXBhT10uUPntd9D3XCgnudzdibRWkPr5w60jBLDpjI=;
        b=OOuiwV1WCP7fx6zHQitHozYfM6nr5LVVrRVBdfH3QjhZbsXiM45Y+1WzgqV8PACqHTRn1k
        tSPkEZXej0kSlNibXi09Yr/STNq7RnbPxtsGt2jFQ6Fl4v8OjGiHJgHyr7JL3SMC37dRYD
        pQ2yboET3ZDazpu5GkYbJZWa7SKwzr8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-189-ZlGF28jtOd2P8PG-nkab5w-1; Wed, 08 Dec 2021 08:47:40 -0500
X-MC-Unique: ZlGF28jtOd2P8PG-nkab5w-1
Received: by mail-lf1-f72.google.com with SMTP id d26-20020ac244da000000b00417e1d212a2so1141935lfm.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 05:47:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent:cc
         :subject:content-language:to:references:in-reply-to
         :content-transfer-encoding;
        bh=WgXBhT10uUPntd9D3XCgnudzdibRWkPr5w60jBLDpjI=;
        b=AiMbQNcIufdGjuYjWktRus1ik5e7x/8pRiR45PSrmjoxxh7k7mNfsgiXkmaAlKVrIA
         aw+XTxrZDaK9q1fHKk0c9p9zpiHkvyjEiez/evQJFEa705MhKfNNdAkf2GzJDGd7DriC
         g3Yvin+Tv9O7jEICvGW4rnSpQBq6ddEP1/Lk7imP118b1JCMG6NF03Cqgw6mtrPEc8WZ
         K9zgoQUmX7+3O91sfXD5286dGRmECodnpcfqow7tdWVT9ZQGs/7u/mHLymlQYGCytVa0
         Txr+jfJP43t7wNAnRZABB9uCupGd0PlobzR1idq10t279dww0sov+l018s3x1hedef2k
         oQWQ==
X-Gm-Message-State: AOAM530++2bApBa/wK3q7h3YzSzuTh6ofsuBxTZW4aefWKjzx3/Afta5
        rTFAfN2WYSG2KzQDRli4jUr6d8MMCiYPvkADlmWj81vwnar/JcYPtVvdo44BBO3DjB8zJsacYHq
        a6U8NjALUAxxWegCXLxLb1+Gb
X-Received: by 2002:a05:6512:33c4:: with SMTP id d4mr44446286lfg.182.1638971258508;
        Wed, 08 Dec 2021 05:47:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyBhIOzFBLL6AjKxPyHM2J++Vww0G7j189KtWPTFzpPdI2id9zE+pRzYQH9ANJkJY/Y/JcAlA==
X-Received: by 2002:a05:6512:33c4:: with SMTP id d4mr44446255lfg.182.1638971258261;
        Wed, 08 Dec 2021 05:47:38 -0800 (PST)
Received: from [192.168.0.50] (87-59-106-155-cable.dk.customer.tdc.net. [87.59.106.155])
        by smtp.gmail.com with ESMTPSA id k8sm259731lfv.179.2021.12.08.05.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 05:47:37 -0800 (PST)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <87463ddc-bf93-99cc-65d1-cbc215125ec3@redhat.com>
Date:   Wed, 8 Dec 2021 14:47:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Cc:     brouer@redhat.com, Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Andre Guedes <andre.guedes@intel.com>,
        Vedang Patel <vedang.patel@intel.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v3 net-next 9/9] i40e: respect metadata on XSK Rx to skb
Content-Language: en-US
To:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        intel-wired-lan@lists.osuosl.org
References: <20211207205536.563550-1-alexandr.lobakin@intel.com>
 <20211207205536.563550-10-alexandr.lobakin@intel.com>
In-Reply-To: <20211207205536.563550-10-alexandr.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/12/2021 21.55, Alexander Lobakin wrote:
> For now, if the XDP prog returns XDP_PASS on XSK, the metadata will
> be lost as it doesn't get copied to the skb.
> Copy it along with the frame headers. Account its size on skb
> allocation, and when copying just treat it as a part of the frame
> and do a pull after to "move" it to the "reserved" zone.
> net_prefetch() xdp->data_meta and align the copy size to speed-up
> memcpy() a little and better match ixgbee_costruct_skb().
                                      ^^^^^^^^^^^^^^^^^^^
Misspelling function name.

> 
> Fixes: d0bcacd0a130 ("ixgbe: add AF_XDP zero-copy Rx support")
> Suggested-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)

Wrong driver (i40e:) "tagged" in subject.

