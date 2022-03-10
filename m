Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0CC4D47EE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 14:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242350AbiCJNTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 08:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235049AbiCJNTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 08:19:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E006D14CCB4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 05:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646918326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AaTbB2RahE2iSsLEKGIK/+Kc7seBWLeb+3YRDkkqjx4=;
        b=Gv7Wvvc4nGZXCd/Op0hrgw5y+QsPwVwfmzrDWi60ojX1UThSrVFrYSObE8gDbzjNENE1rB
        7+LSQL4prO9zwtJrtWtYkPU+Jt9L8gQ0UFDlc7duHUZ32C/8Zt92xrQb+GZG61m+x0Ix+e
        F1iHdwrGEKyaZF1WCxtSf0owK+HETDA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-576-RaGOYQUcNUe-qVNJB-9jEQ-1; Thu, 10 Mar 2022 08:18:44 -0500
X-MC-Unique: RaGOYQUcNUe-qVNJB-9jEQ-1
Received: by mail-wm1-f71.google.com with SMTP id l2-20020a1ced02000000b0038482a47e7eso4059285wmh.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 05:18:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AaTbB2RahE2iSsLEKGIK/+Kc7seBWLeb+3YRDkkqjx4=;
        b=o4VJK+LcJnhS8tjzEULzlDSC+peQH7FKxqp2EszkZd4x6seFVI33bIuaKhIeY464sC
         lXEerCk3wX3CNPfsPEZ2Aold3bdsxy4NesyOd4Bl7i5r/yyteXkvvgerG3+1+k0Zw0rk
         K1i96Zlb6WildYdElC2jPNkf+89QMp2vIC8DJP3TMaGpZuawgRLu86tcVDA/vwzcz1o5
         y4CgbHdofsUgBgqMiC8K1CZdnSSqf3LdzE96s/k++ndDn7dd0xD3UeKK6V4fi08PkyZp
         1Pkne1k9VZvt+J7zYM0ksZk72t55p6AWeIsmgap/yi8IAeTtgPp8kRkeox7ZlGiVu7gl
         S/7A==
X-Gm-Message-State: AOAM532Xxkzmk+SWgXZGw97ujCxxBm4qPV7D1vU++SYDmyvRANnARFn1
        epgGSKtrQbBlP4u1+SDIh+H4EKFg+gSG8R7HTvMJLEUrwzU4BB1VwsGinwPZtWwmZKTBAWKgUgP
        s4aJzWYWwKVT6wOrDe4ja3xKF
X-Received: by 2002:a7b:c950:0:b0:389:5328:aaa8 with SMTP id i16-20020a7bc950000000b003895328aaa8mr11586107wml.181.1646918323723;
        Thu, 10 Mar 2022 05:18:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwgKzmba4zXEK9HNLZC+24bVU+g+AF7pxzMEvmqeryAY76nPWFmYDcFtEAkBo6cbDhsgwwGRQ==
X-Received: by 2002:a7b:c950:0:b0:389:5328:aaa8 with SMTP id i16-20020a7bc950000000b003895328aaa8mr11586085wml.181.1646918323452;
        Thu, 10 Mar 2022 05:18:43 -0800 (PST)
Received: from sgarzare-redhat (host-212-171-187-184.pool212171.interbusiness.it. [212.171.187.184])
        by smtp.gmail.com with ESMTPSA id y2-20020a056000108200b001f078fc13a7sm4335669wrw.73.2022.03.10.05.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 05:18:42 -0800 (PST)
Date:   Thu, 10 Mar 2022 14:18:40 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jiyong Park <jiyong@google.com>, stefanha@redhat.com,
        jasowang@redhat.com, davem@davemloft.net, kuba@kernel.org,
        adelva@google.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] vsock: each transport cycles only on its own sockets
Message-ID: <20220310131840.274kduoa3tn4c7yy@sgarzare-redhat>
References: <20220310125425.4193879-1-jiyong@google.com>
 <20220310125425.4193879-2-jiyong@google.com>
 <20220310075933-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220310075933-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 08:01:53AM -0500, Michael S. Tsirkin wrote:
>On Thu, Mar 10, 2022 at 09:54:24PM +0900, Jiyong Park wrote:
>> When iterating over sockets using vsock_for_each_connected_socket, make
>> sure that a transport filters out sockets that don't belong to the
>> transport.
>>
>> There actually was an issue caused by this; in a nested VM
>> configuration, destroying the nested VM (which often involves the
>> closing of /dev/vhost-vsock if there was h2g connections to the nested
>> VM) kills not only the h2g connections, but also all existing g2h
>> connections to the (outmost) host which are totally unrelated.
>>
>> Tested: Executed the following steps on Cuttlefish (Android running on a
>> VM) [1]: (1) Enter into an `adb shell` session - to have a g2h
>> connection inside the VM, (2) open and then close /dev/vhost-vsock by
>> `exec 3< /dev/vhost-vsock && exec 3<&-`, (3) observe that the adb
>> session is not reset.
>>
>> [1] https://android.googlesource.com/device/google/cuttlefish/
>>
>> Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>> Signed-off-by: Jiyong Park <jiyong@google.com>
>> ---
>>  drivers/vhost/vsock.c            | 4 ++++
>>  net/vmw_vsock/virtio_transport.c | 7 +++++++
>>  net/vmw_vsock/vmci_transport.c   | 5 +++++
>>  3 files changed, 16 insertions(+)
>>
>> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>> index 37f0b4274113..853ddac00d5b 100644
>> --- a/drivers/vhost/vsock.c
>> +++ b/drivers/vhost/vsock.c
>> @@ -722,6 +722,10 @@ static void vhost_vsock_reset_orphans(struct sock *sk)
>>  	 * executing.
>>  	 */
>>
>> +	/* Only handle our own sockets */
>> +	if (vsk->transport != &vhost_transport.transport)
>> +		return;
>> +
>>  	/* If the peer is still valid, no need to reset connection */
>>  	if (vhost_vsock_get(vsk->remote_addr.svm_cid))
>>  		return;
>
>
>We know this is incomplete though. So I think it's the wrong thing to do
>when you backport, too. If all you worry about is breaking a binary
>module interface, how about simply exporting a new function when you
>backport. Thus you will have downstream both:
>
>void vsock_for_each_connected_socket(void (*fn)(struct sock *sk));
>
>void vsock_for_each_connected_socket_new(struct vsock_transport *transport,
>                                    void (*fn)(struct sock *sk));
>
>
>and then upstream we can squash these two patches.
>
>Hmm?
>

Yep, reading more of the kernel documentation [1] it seems that upstream 
we don't worry about this.

I agree with Michael, it's better to just have the final patch upstream 
and downstream will be handled accordingly.

This should make it easier upstream to backport into stable branches 
future patches that depend on this change.

Thanks,
Stefano

[1] 
https://www.kernel.org/doc/Documentation/process/stable-api-nonsense.rst

