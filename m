Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A924B5B07A3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiIGOz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiIGOzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:55:38 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1922986B5A;
        Wed,  7 Sep 2022 07:55:05 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 73871920CA7;
        Wed,  7 Sep 2022 14:55:01 +0000 (UTC)
Received: from pdx1-sub0-mail-a308 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id E49C9921720;
        Wed,  7 Sep 2022 14:55:00 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1662562501; a=rsa-sha256;
        cv=none;
        b=3Cbtj+QgfD5v6mvODR0gJHigGaNJYEnaTOArikKYoHobDtgMnSUxZIMqoyrHTlV/gadwmG
        TYxRma6k31jXKiSW+5j2LQLLnzLI/2DPnTxwsGOw9rE8DWbqAEJewpHwRr4k2jo/rcdCO5
        SXM4QWMLxKk9ISK20rz0xSkY6KJubPH9jiwBu2D6faPMRUE7suDfrnI9YU5bvHKUSRL3Lt
        6utWWNo5pBnf0YCFWl4BC96WMA8tDxF6113U7R/gRdyC1/9cm4xD49vd2Tyov42Cf4O2DD
        6zSl0p7yXHZW1Dma0MoJTt9dtwn09pL99Sq9cGvNWAK6d3dxWT+AHtWtKjHI6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1662562501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=/a1y1ajhOu+dgDM9IiBP6SBBRRgVgt1du7NEURDFIMM=;
        b=iqpTyWkVqInKbOg8ZIOy+r9ry+QBIV2CIq3ge7BXD19viYNXw7rGW419dBo9iurV55rANi
        mvVc0r1/sq4/ONHWlEpT/P6Sknas8nh2V5vKIhcsXGmFH76Q1jfTT+jNJei8+NyXpLMn4i
        hf4X2A02Bn7y1ByN80TRxP7c4wHVWLyKzcNmdduXzv12mz7Ux/qmczAwIuRALWM3asWFN3
        ajbUW6RvrvAj1ux2hh1UedEaM4eTFunzm7GSWeCb7CKi2axNDhKqQzdWaJ8LliIjb/WklA
        s/Ccina+haAaZcmM2WzWWvJPk+Lls6k/SNs8rB1cNi+nS0s7lNjcxFfft8rB0g==
ARC-Authentication-Results: i=1;
        rspamd-f776c45b8-qkcxd;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Coil-Ski: 4eda7c667a69c7d6_1662562501274_4112141017
X-MC-Loop-Signature: 1662562501274:3431010349
X-MC-Ingress-Time: 1662562501274
Received: from pdx1-sub0-mail-a308 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.117.103.197 (trex/6.7.1);
        Wed, 07 Sep 2022 14:55:01 +0000
Received: from offworld (unknown [104.36.31.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a308 (Postfix) with ESMTPSA id 4MN4zk4cv2z2m;
        Wed,  7 Sep 2022 07:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1662562500;
        bh=/a1y1ajhOu+dgDM9IiBP6SBBRRgVgt1du7NEURDFIMM=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=YfxR/fvYcVWGXIJT6VAQgJrbTuzNrjtTJc0OM+JDu82lXV8wVoOjhxBooKVBHiVVg
         p3NP7YDlwder/6Wef+RpEm9L1zrHd4iSkzG0PnkXCHHsiNLs6yFFpSpP4qcZLwVicQ
         9TlXhKjFkumfGa7Ub1g6tjWCxw+AX/FcRSEhfoEw8Bzu/dajPX5SJOMIuAj9zrM5hp
         5ouJYWBpUlNxVpiwrrRiAXtWSmWeaJwe+xGT/XZi0trAyutkRno5V1yfmmd8MTa+2Q
         hzwClx1LL3UOFB1FuPMwMgYxfa+3oD1d8NiLPQtysqxmkQgO55s8betsUYIDaeFmqi
         9PXJslUNSC+HQ==
Date:   Wed, 7 Sep 2022 07:36:03 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     x86@kernel.org, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
        peterz@infradead.org, bp@alien8.de, akpm@linux-foundation.org,
        dave.jiang@intel.com, Jonathan.Cameron@huawei.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        a.manzanares@samsung.com, linux-kernel@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH -next] memregion: Add arch_flush_memregion() interface
Message-ID: <20220907143603.d226eyi3uitlcmi5@offworld>
References: <20220829212918.4039240-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220829212918.4039240-1-dave@stgolabs.net>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure the proper way to route this (akpm?). But unless any remaining
objections, could this be picked up?

Thanks,
Davidlohr
