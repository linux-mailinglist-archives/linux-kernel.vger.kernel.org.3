Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88ECF4DC4C1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbiCQLYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbiCQLYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:24:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D3834C4C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647516178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bsgRjbBVd7zKEbu9S910DtGPMRTNr4oCmC9+DDFhffo=;
        b=Si/y7m6tbV0FsC8fzjGKtPo1zEnidQ8jiMJKHCbDR1gNVO6TQHBr+X+WLhFII1QwcWyvFn
        T8IzRb2TkwsE81AnsB8DaN6+Xpkfn2Q8u9AFGN2ZqYkf1UcVvfV7rxNyuh7d8FQ2ZPO8qE
        EY19m4FQjtRyLmitJH80dx7k5B+D3eQ=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-303-HFg8hIU-Ora2tCmdR9-eqw-1; Thu, 17 Mar 2022 07:22:57 -0400
X-MC-Unique: HFg8hIU-Ora2tCmdR9-eqw-1
Received: by mail-pg1-f197.google.com with SMTP id v8-20020a637a08000000b00381ef25b6b8so1631253pgc.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:22:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bsgRjbBVd7zKEbu9S910DtGPMRTNr4oCmC9+DDFhffo=;
        b=dw8e2LngQevY+/Vcl8jGGG6z/bgLz+w1FBb9RYXWgxnuQF145zhlBJ17dRkk2mJZDN
         RXxxxceIrKZku0gkWGYeG7mVWqzwzikIihedfcIUWikAKUcv0cbBWm7CClm+xHUhkLBy
         jiCDIbWTceIBSLX2KQLfo+p2Z1gMPjdIAQJKG9fuL77nCz42xUheEfunCyZbFwejNyLz
         6vs/7sTSLEbb3Q1Tk+RB9r5/HnLm+P4W013uig3zKZGcLnjcFBQCO01PwoIpLvgE38j5
         5L4nxTliQQOZ3p755uEJQr6M6wbdSqIKAkj0u2gHMn2a6l7bAzsxqqEmAuNSBJ4lhbIP
         +f5A==
X-Gm-Message-State: AOAM5318R1r5GNkylZildESdiBTVaUoX2Oikr7PhxvR/ubYYmuB+4qaR
        UOgU3ryY78hEpKsikqsSn0BF5zTK0nfEsV0b7amHZTv5oWBThL+wRnxzXqDU/o8G7rg4x0TzDVv
        Ebj1Rt2+JfmLWMgchDPTTX4OJOAge00Y04f25wMV+hIgM3IMrFBGsWjwbjsaF/2xm07wxPj/KAg
        ==
X-Received: by 2002:a62:7c58:0:b0:4f6:ebf1:e78d with SMTP id x85-20020a627c58000000b004f6ebf1e78dmr4490305pfc.18.1647516174364;
        Thu, 17 Mar 2022 04:22:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJ5Kz+Y4kubyDwK7WJUpc/wDXQaNpOKiKTppnvhmcBgqm7afzfGgdM1Xfm7MmZMOsAh6Mb9g==
X-Received: by 2002:a62:7c58:0:b0:4f6:ebf1:e78d with SMTP id x85-20020a627c58000000b004f6ebf1e78dmr4490263pfc.18.1647516174017;
        Thu, 17 Mar 2022 04:22:54 -0700 (PDT)
Received: from [10.72.12.110] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 9-20020a621909000000b004f6f40195f8sm6124070pfz.133.2022.03.17.04.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 04:22:53 -0700 (PDT)
Subject: Re: [RFC PATCH v2 0/3] ceph: add support for snapshot names
 encryption
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <20220315161959.19453-1-lhenriques@suse.de>
 <5b53e812-d49b-45f0-1219-3dbc96febbc1@redhat.com>
 <87bky4j36l.fsf@brahms.olymp>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <d813d2d3-2493-59b1-9a68-8dd533e83452@redhat.com>
Date:   Thu, 17 Mar 2022 19:22:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <87bky4j36l.fsf@brahms.olymp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/17/22 6:14 PM, Luís Henriques wrote:
> Xiubo Li <xiubli@redhat.com> writes:
>
>> Hi Luis,
>>
>> There has another issue you need to handle at the same time.
>>
>> Currently only the empty directory could be enabled the file encryption, such as
>> for the following command:
>>
>> $ fscrypt encrypt mydir/
>>
>> But should we also make sure that the mydir/.snap/ is empty ?
>>
>> Here the 'empty' is not totally empty, which allows it should allow long snap
>> names exist.
>>
>> Make sense ?
> Right, actually I had came across that question in the past but completely
> forgot about it.
>
> Right now we simply check the dir stats to ensure a directory is empty.
> We could add an extra check in ceph_crypt_empty_dir() to ensure that there
> are no snapshots _above_ that directory (i.e. that there are no
> "mydir/.snap/_name_xxxxx").

Check this only in ceph_crypt_empty_dir() seems not enough, at least not 
graceful.

Please see 
https://github.com/google/fscrypt/blob/master/cmd/fscrypt/commands.go#L305.

The google/fscrypt will read that directory to check where it's empty or 
not. So eventually we may need to fix it there. But for a workaround you 
may could fix it in ceph_crypt_empty_dir() and ceph_ioctl() when setting 
the key or policy ?

-- Xiubo


>
> Unfortunately, I don't know enough of snapshots implementation details to
> understand if it's a problem to consider a directory as being empty (in
> the fscrypt context) when there are these '_name_xxx' directories.  My
> feeling is that this is not a problem but I really don't know.
>
> Do you (or anyone) have any ideas/suggestions?
>
> Cheers,

