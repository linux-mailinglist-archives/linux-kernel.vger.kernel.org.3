Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF89546D57
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 21:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348489AbiFJTgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 15:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344509AbiFJTgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 15:36:45 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EA6101EE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 12:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ygCFBqZbkR6suCHUcTKZ8do/gLGGzc7CS3f6CgBBhbs=;
        t=1654889802; x=1656099402; b=t2sOq5LuXrPbBiAjbwbpuqYrsXdK2pWJG2H8EYXsP8aPsYm
        2LqulIizGXuA0bl5OmvJft3jjTURhqgdn29EA2019zZU0rttPtxlLOqu0UssHuqp4a5blxVCQeuVg
        sRttW0YcJdboW9w+QDVMRFTEXJWk3l9KN3WGxFRnU9zYJs6R4PxU8RPp11xGncm1X1VmCszSZYiF0
        OeIKUrBVxJHAaptH4wtBP1wEINNWPedac7Dm3Kv5WJm5MRcyeip4y63ThbqPVDBUzEcVm7VNZojuZ
        Ou2DZElorKTL+8ue2FqYjRMUNc7VBZ+bFbeU6qtG7mHNUeLmV4ucknIbzHxOzm/g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nzkQi-001dhU-N4;
        Fri, 10 Jun 2022 21:36:24 +0200
Message-ID: <3670b59063e3815f281c602d6f88dde8e9b1c50f.camel@sipsolutions.net>
Subject: Re: [PATCH] um: virt-pci: set device ready in probe()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     kernel@axis.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Fri, 10 Jun 2022 21:36:23 +0200
In-Reply-To: <20220610151203.3492541-1-vincent.whitchurch@axis.com>
References: <20220610151203.3492541-1-vincent.whitchurch@axis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-06-10 at 17:12 +0200, Vincent Whitchurch wrote:
> Call virtio_device_ready() to make this driver work after commit
> b4ec69d7e09 ("virtio: harden vring IRQ"), since the driver uses the
> virtqueues in the probe function.  (The virtio core sets the device
> ready when probe returns.)
>=20
> Fixes: 8b4ec69d7e09 ("virtio: harden vring IRQ")
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Thank you! I had apparently run into this a few days ago, but hadn't had
a chance to debug it yet. This patch fixes my test setup on 5.19-rc1.

Tested-by: Johannes Berg <johannes@sipsolutions.net>

johannes
