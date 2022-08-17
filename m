Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B085975AA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 20:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240633AbiHQSYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 14:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbiHQSYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 14:24:49 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9EE9A99C
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 11:24:48 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id s23so7043499wmj.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 11:24:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=6XoCRWTpHFxKAXiFtoAE096KFo+xlJ75DyKMVWp9KjE=;
        b=IisT/QisJMV03o7p/no2GE0XQ9vWYK9VVnRXWW72lQAG7jSorJtsgafcOY7mPkpv85
         lNQUCmkd+KwU1snCAFCmHgTJEV6W5ml4A2rs/AK2J6vb5yrTbuZkAIlX/nCPBfvzjDtx
         moe2G6vbzH9khfPxSVZuMRYlamoxFZS6j0DrT118zwPgeLByPL5fvwZ+NPk4e8ibcCPK
         bw0d+1yA9YXwapRSKhA6zeQBEufVZB3484Koozg+bFDx01Fk5LcDj8Xcr7NJhGe4tubd
         sjmzE2/cblJTZ0vFYSS5CbINqH+kiD5n80O9tzqBAL03uBjS94VJyC45JXYdiUzA8+Yg
         gPIg==
X-Gm-Message-State: ACgBeo2sI/Gg8KZ9y0D3Had7QUx1kOn0q2kNKFRu/7y5lW1zG+Uz2SPG
        26qTZzrSBNUSKnOad1BYXWI=
X-Google-Smtp-Source: AA6agR6LAY7RcTFsAxJ/3LYoG+1PdOZtBozR/j5W5+DEosWciHEvkrT+THm9dB3Vn7RsIHRg4rtWNw==
X-Received: by 2002:a05:600c:1906:b0:3a5:f9e0:fcb6 with SMTP id j6-20020a05600c190600b003a5f9e0fcb6mr3044330wmq.157.1660760686884;
        Wed, 17 Aug 2022 11:24:46 -0700 (PDT)
Received: from [10.100.102.14] (85-250-24-41.bb.netvision.net.il. [85.250.24.41])
        by smtp.gmail.com with ESMTPSA id j17-20020adfe511000000b00225239d9265sm2840786wrm.74.2022.08.17.11.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 11:24:46 -0700 (PDT)
Message-ID: <581ecec9-8f2b-32a2-6ce1-63551496e332@grimberg.me>
Date:   Wed, 17 Aug 2022 21:24:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvmet-tcp: Don't kmap() pages which can't come from
 HIGHMEM
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>
References: <20220817170427.15682-1-fmdefrancesco@gmail.com>
 <Yv0o9MlqCjXUcDKc@kbusch-mbp.dhcp.thefacebook.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <Yv0o9MlqCjXUcDKc@kbusch-mbp.dhcp.thefacebook.com>
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


>> @@ -329,7 +312,6 @@ static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd)
>>   	u32 length, offset, sg_offset;
>>   
>>   	length = cmd->pdu_len;
>> -	cmd->nr_mapped = DIV_ROUND_UP(length, PAGE_SIZE);
>>   	offset = cmd->rbytes_done;
>>   	cmd->sg_idx = offset / PAGE_SIZE;
>>   	sg_offset = offset % PAGE_SIZE;
>> @@ -338,7 +320,7 @@ static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd)
>>   	while (length) {
>>   		u32 iov_len = min_t(u32, length, sg->length - sg_offset);
>>   
>> -		iov->iov_base = kmap(sg_page(sg)) + sg->offset + sg_offset;
>> +		iov->iov_base = page_address(sg_page(sg)) + sg->offset + sg_offset;
>>   		iov->iov_len = iov_len;
>>   
>>   		length -= iov_len;
>> @@ -347,8 +329,7 @@ static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd)
>>   		sg_offset = 0;
>>   	}
>>   
>> -	iov_iter_kvec(&cmd->recv_msg.msg_iter, READ, cmd->iov,
>> -		cmd->nr_mapped, cmd->pdu_len);
>> +	iov_iter_kvec(&cmd->recv_msg.msg_iter, READ, cmd->iov, 0, cmd->pdu_len);
>>   }
> 
> I earlier meant just use a local variable for 'nr_mapped' rather than replace
> it with '0'. I don't think that 0 segments would result in usable kvec.

yes, that is wrong. Need a local int nr_mapped variable.

> 
> I'm not even sure the existing code is correct, though. The sg->length can be
> higher order than a PAGE_SIZE, so it may be over-reporting nr_segs. It's just
> supposed to be the number of initialized iov's.

The sg is allocated with sgl_alloc so it is for sure 0-order.
