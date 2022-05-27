Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C97535B05
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348539AbiE0IF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348662AbiE0IEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:04:55 -0400
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D94EFF5A2
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 01:04:49 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.191.102])
        by smtp.orange.fr with ESMTPA
        id uUxinqBKs26JCuUxinnMVg; Fri, 27 May 2022 10:04:47 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 27 May 2022 10:04:47 +0200
X-ME-IP: 90.11.191.102
Message-ID: <fa54e172-ef9d-fba5-ad37-72a6698c7cb8@wanadoo.fr>
Date:   Fri, 27 May 2022 10:04:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
X-Mozilla-News-Host: news://news.gmane.org:119
Content-Language: fr
To:     kch@nvidia.com
Cc:     jasowang@redhat.com, linux-block@vger.kernel.org, mst@redhat.com,
        pbonzini@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        keliu <liuke94@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH 4/4] virtio-blk: remove deprecated ida_simple_XXX()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Resend, my email client sent it as HTML. So sorry for the duplicate)


Hi,

 > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
 > index 74c3a48cd1e5..e05748337dd1 100644
 > --- a/drivers/block/virtio_blk.c
 > +++ b/drivers/block/virtio_blk.c
 > @@ -720,8 +720,8 @@ static int virtblk_probe(struct virtio_device *vdev)
 > 		return -EINVAL;
 > 	}
 >
 >-	err = ida_simple_get(&vd_index_ida, 0, minor_to_index(1 << MINORBITS),
 >-			     GFP_KERNEL);
 >+	err = ida_alloc_max(&vd_index_ida, minor_to_index(1 << MINORBITS),
 >+			    GFP_KERNEL);
 > 	if (err < 0)
 > 		goto out;
 > 	index = err;


this patch, already applied to -next, is wrong.


The upper bound of ida_simple_get() is exlcusive, while the one of 
ida_alloc_max() is inclusive.

So, 'minor_to_index(1 << MINORBITS)' should be 'minor_to_index(1 << 
MINORBITS) - 1' here.


(adding keliu in cc: because he is proposing the same kind of patches, 
so he will see how to to these changes that are slighly tricky)


CJ

