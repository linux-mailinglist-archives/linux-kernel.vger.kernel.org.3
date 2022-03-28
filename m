Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF4D4E92F3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240448AbiC1LDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240482AbiC1LDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:03:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1A2755215
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648465281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UKxKy6FDdIa4hDOHZBvGuXdeO6wMi/JeEf+z3rIDYXY=;
        b=IPiLp5Qqn0asnyPE9L3z4t1fr1AeC1QWB6a4ju785/mTvZp4932ExMzCaEA5HnGaSvScnl
        iYTHb0Uju/12Pfex9QGD2XMvsPjYC4Z1iVVKcxnQK1OmWslMF/N0O08fki9hl5MayugOZH
        hFygznHG/C+dhAT30MLBjH+3m/yWE3o=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-73-ucPzIMKDMNeKUUp5jHNoBg-1; Mon, 28 Mar 2022 07:01:20 -0400
X-MC-Unique: ucPzIMKDMNeKUUp5jHNoBg-1
Received: by mail-pf1-f200.google.com with SMTP id 72-20020a62154b000000b004fb53e16d5dso1959802pfv.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UKxKy6FDdIa4hDOHZBvGuXdeO6wMi/JeEf+z3rIDYXY=;
        b=ZJSZeVfpbZ6dG2p1Cz94077mC81W07qVvbho60Lt+I8YyBNONDtogd8kyb0lcOKF01
         oxrY/nbAnsnu/toYncwcPiBKEwVzp4R+Dm74NJn4HzBXcV4djOtiidxF6YM+GPkN99sI
         waoQ8U9ZQH3iqk9RJJ9LoGWK8Qr1G/hT2P5CEkxEpe/Z39sAw5tc+Gla4Atfknycnw5T
         paiG2JumUd8YUm8iWPoeo90gh2fxobb0qhQ+ANkPzEFNVEqpR1ZHWr/YYor3/rEEyGM+
         JcQOMPbZnwlSb8d62AgjhaUBxwmL9F91E1bmFXjq7fJisTBAGD9gAcNp/6632GTfiiZM
         RifA==
X-Gm-Message-State: AOAM532IAZYrZSmNaowD/N9J4kN3DEBXdGLO3hF5ijt8tNrqi3JljepL
        Fq2yT1DujrP6f1JaNiG34yNsby9mu7HhAgsxTX6yAGhvxBx+LfmD+OtIBDSZ0QT+e+PhinBWgy1
        PLlOu1x+FKGK2QqZIUVKlv3/9Ys+HnDjuj0PibdnUTSGhCTDpges/eZcpa3isaWzAH5T9iXJvnw
        ==
X-Received: by 2002:a05:6a00:1824:b0:4f6:dc69:227e with SMTP id y36-20020a056a00182400b004f6dc69227emr22988781pfa.58.1648465279206;
        Mon, 28 Mar 2022 04:01:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWsF/rOQW4VzWWnF9SO4O/nJjf2rzGqUtdvSWob4dD4JBVf2mGN3/5Xj6H863B9llPOls9rQ==
X-Received: by 2002:a05:6a00:1824:b0:4f6:dc69:227e with SMTP id y36-20020a056a00182400b004f6dc69227emr22988747pfa.58.1648465278804;
        Mon, 28 Mar 2022 04:01:18 -0700 (PDT)
Received: from [10.72.12.110] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b10-20020a056a00114a00b004f784ba5e6asm16553387pfm.17.2022.03.28.04.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 04:01:18 -0700 (PDT)
Subject: Re: [PATCH] ceph: remove unused CEPH_MDS_LEASE_RELEASE related code
To:     Jeff Layton <jlayton@kernel.org>
Cc:     idryomov@gmail.com, vshankar@redhat.com,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220328022535.847164-1-xiubli@redhat.com>
 <cd928bbbba3260dfe6ce4a964185a377b4a767cd.camel@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <89f76eef-42e3-1469-5329-bd6512490bf6@redhat.com>
Date:   Mon, 28 Mar 2022 19:01:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <cd928bbbba3260dfe6ce4a964185a377b4a767cd.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/28/22 6:28 PM, Jeff Layton wrote:
> On Mon, 2022-03-28 at 10:25 +0800, xiubli@redhat.com wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> The ceph_mdsc_lease_release() has been removed by commit(8aa152c77890)
>> and the CEPH_MDS_LEASE_RELEASE will never be used.
>>
> Like it says in Documentation/process/5.Posting.rst:
>
> "...and please provide both the commit ID and the title when citing
> commits"
>
> You might want to reword this with something like:
>
> "ceph_mdsc_lease_release was removed by commit 8aa152c77890 (ceph:
> remove ceph_mdsc_lease_release). ceph_mdsc_lease_send_msg will never
> call this function with CEPH_MDS_LEASE_RELEASE."

Sure, will fix it.


>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>   fs/ceph/mds_client.c | 6 ------
>>   1 file changed, 6 deletions(-)
>>
>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
>> index 459c6f23915f..a89ee866ebbb 100644
>> --- a/fs/ceph/mds_client.c
>> +++ b/fs/ceph/mds_client.c
>> @@ -4424,12 +4424,6 @@ void ceph_mdsc_lease_send_msg(struct ceph_mds_session *session,
>>   	memcpy((void *)(lease + 1) + 4,
>>   	       dentry->d_name.name, dentry->d_name.len);
>>   	spin_unlock(&dentry->d_lock);
>> -	/*
>> -	 * if this is a preemptive lease RELEASE, no need to
>> -	 * flush request stream, since the actual request will
>> -	 * soon follow.
>> -	 */
>> -	msg->more_to_follow = (action == CEPH_MDS_LEASE_RELEASE);
>>   
>>   	ceph_con_send(&session->s_con, msg);
>>   }
> It might be possible to trim this function back further. There's only
> one caller and it always calls this with the same "action" value. Still,
> this looks fine...

Yeah, I checked the commit history in both kernel and ceph, it seems 
never used since this was introduced. Maybe I missed something.

The user space clients is use the CEPH_MDS_LEASE_RELEASE as the lease 
revoke ack. In kernel we are using the CEPH_MDS_LEASE_REVOKE_ACK instead.

Thanks.

>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>

