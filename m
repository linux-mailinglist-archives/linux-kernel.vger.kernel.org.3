Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E91E57CA17
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 13:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbiGULz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 07:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbiGULzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 07:55:47 -0400
Received: from smtp236.sjtu.edu.cn (smtp236.sjtu.edu.cn [202.120.2.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A2874CC8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 04:55:41 -0700 (PDT)
Received: from proxy02.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
        by smtp236.sjtu.edu.cn (Postfix) with ESMTPS id 0FF5C1008AED8;
        Thu, 21 Jul 2022 19:55:38 +0800 (CST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by proxy02.sjtu.edu.cn (Postfix) with ESMTP id E568E2008B6BB;
        Thu, 21 Jul 2022 19:55:38 +0800 (CST)
X-Virus-Scanned: amavisd-new at 
Received: from proxy02.sjtu.edu.cn ([127.0.0.1])
        by localhost (proxy02.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vSRyE9_Mjxh7; Thu, 21 Jul 2022 19:55:38 +0800 (CST)
Received: from [192.168.24.189] (unknown [202.120.40.82])
        (Authenticated sender: qtxuning1999@sjtu.edu.cn)
        by proxy02.sjtu.edu.cn (Postfix) with ESMTPSA id 98B28200A5C04;
        Thu, 21 Jul 2022 19:55:31 +0800 (CST)
Message-ID: <4185ee25-52af-8271-c4de-3824490fba6a@sjtu.edu.cn>
Date:   Thu, 21 Jul 2022 19:55:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 0/4] virtio/virtio_test
Content-Language: en-US
To:     jasowang@redhat.com, mst@redhat.com
Cc:     eperezma@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, sgarzare@redhat.com
References: <20220709022745.21020-1-qtxuning1999@sjtu.edu.cn>
From:   Guo Zhi <qtxuning1999@sjtu.edu.cn>
In-Reply-To: <20220709022745.21020-1-qtxuning1999@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/9 10:27, Guo Zhi wrote:
> Original virtio_test only use add one descriptor for each io event, thus code of descriptor chain and indirection have not been tested(one descriptor will not use indirect feature even indirect feature has been specified). In fact it would have not been possible for vhost_test to access to the indirect descriptor table, because it's impossible for virtio_ring.c to allocate it.
>
> This series using descriptor chain and enable indirection feature. And through gcov we find the code coverage has been improved(not high for virtio_ring.c because virtio_test only test split virtqueue):
>
> +------------+-------------+-------------+
> |            |virtio_test.c|virtio_ring.c|
> +------------+-------------+-------------+
> | original   |   72.32%    |   24.71%    |
> +------------+-------------+-------------+
> | current    |    75%      |   28.05%    |
> +------------+-------------+-------------+
>
> Guo Zhi (4):
>    virtio_test: kick vhost for a batch of descriptors
>    virtio_test: use random length scatterlists to test descriptor chain
>    virtio_test: enable indirection feature
>    virtio_test: pregenerate random numbers
>
>   tools/virtio/virtio_test.c | 85 ++++++++++++++++++++++++++++++--------
>   1 file changed, 68 insertions(+), 17 deletions(-)
>
Hi, the new version patch of virtio_test is waiting for review:)

Thanks.

