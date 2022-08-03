Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF825888FC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbiHCJBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiHCJBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:01:08 -0400
Received: from smtp237.sjtu.edu.cn (smtp237.sjtu.edu.cn [202.120.2.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651B4286D3
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 02:01:04 -0700 (PDT)
Received: from mta91.sjtu.edu.cn (unknown [10.118.0.91])
        by smtp237.sjtu.edu.cn (Postfix) with ESMTPS id 3890B10087D61;
        Wed,  3 Aug 2022 17:01:00 +0800 (CST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mta91.sjtu.edu.cn (Postfix) with ESMTP id EE83E37C93E;
        Wed,  3 Aug 2022 17:00:59 +0800 (CST)
X-Virus-Scanned: amavisd-new at 
Received: from mta91.sjtu.edu.cn ([127.0.0.1])
        by localhost (mta91.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ST7DrKPqboO2; Wed,  3 Aug 2022 17:00:59 +0800 (CST)
Received: from mstore105.sjtu.edu.cn (mstore101.sjtu.edu.cn [10.118.0.105])
        by mta91.sjtu.edu.cn (Postfix) with ESMTP id C4AC737C93D;
        Wed,  3 Aug 2022 17:00:59 +0800 (CST)
Date:   Wed, 3 Aug 2022 17:00:59 +0800 (CST)
From:   Guo Zhi <qtxuning1999@sjtu.edu.cn>
To:     jasowang <jasowang@redhat.com>, Michael Tsirkin <mst@redhat.com>
Cc:     eperezma <eperezma@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        sgarzare <sgarzare@redhat.com>
Message-ID: <2082515061.4772968.1659517259455.JavaMail.zimbra@sjtu.edu.cn>
In-Reply-To: <4185ee25-52af-8271-c4de-3824490fba6a@sjtu.edu.cn>
References: <20220709022745.21020-1-qtxuning1999@sjtu.edu.cn> <4185ee25-52af-8271-c4de-3824490fba6a@sjtu.edu.cn>
Subject: Re: [PATCH v3 0/4] virtio/virtio_test
MIME-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
X-Originating-IP: [36.148.64.77]
X-Mailer: Zimbra 8.8.15_GA_4308 (ZimbraWebClient - GC103 (Mac)/8.8.15_GA_3928)
Thread-Topic: virtio/virtio_test
Thread-Index: sTk/JzG5xzfYKxwClrIRzy7E2UoPqA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- Original Message -----
> From: "Guo Zhi" <qtxuning1999@sjtu.edu.cn>
> To: "jasowang" <jasowang@redhat.com>, "Michael Tsirkin" <mst@redhat.com>
> Cc: "eperezma" <eperezma@redhat.com>, "virtualization" <virtualization@lists.linux-foundation.org>, "linux-kernel"
> <linux-kernel@vger.kernel.org>, "sgarzare" <sgarzare@redhat.com>
> Sent: Thursday, July 21, 2022 7:55:31 PM
> Subject: Re: [PATCH v3 0/4] virtio/virtio_test

> On 2022/7/9 10:27, Guo Zhi wrote:
>> Original virtio_test only use add one descriptor for each io event, thus code of
>> descriptor chain and indirection have not been tested(one descriptor will not
>> use indirect feature even indirect feature has been specified). In fact it
>> would have not been possible for vhost_test to access to the indirect
>> descriptor table, because it's impossible for virtio_ring.c to allocate it.
>>
>> This series using descriptor chain and enable indirection feature. And through
>> gcov we find the code coverage has been improved(not high for virtio_ring.c
>> because virtio_test only test split virtqueue):
>>
>> +------------+-------------+-------------+
>> |            |virtio_test.c|virtio_ring.c|
>> +------------+-------------+-------------+
>> | original   |   72.32%    |   24.71%    |
>> +------------+-------------+-------------+
>> | current    |    75%      |   28.05%    |
>> +------------+-------------+-------------+
>>
>> Guo Zhi (4):
>>    virtio_test: kick vhost for a batch of descriptors
>>    virtio_test: use random length scatterlists to test descriptor chain
>>    virtio_test: enable indirection feature
>>    virtio_test: pregenerate random numbers
>>
>>   tools/virtio/virtio_test.c | 85 ++++++++++++++++++++++++++++++--------
>>   1 file changed, 68 insertions(+), 17 deletions(-)
>>
> Hi, the new version patch of virtio_test is waiting for review:)
> 
> Thanks.

Friendly ping for the patches:)
Thanks
