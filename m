Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81029589730
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 06:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238573AbiHDExW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 00:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiHDExU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 00:53:20 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D382186FC;
        Wed,  3 Aug 2022 21:53:19 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 9E3204C1B95;
        Thu,  4 Aug 2022 04:53:18 +0000 (UTC)
Received: from pdx1-sub0-mail-a254.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 22D024C198D;
        Thu,  4 Aug 2022 04:53:18 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1659588798; a=rsa-sha256;
        cv=none;
        b=UzJ89vCEHfXrGxb4SG4j907x9I3S1kbJQGeF6ZdG/Qg4WkRaYdk0uXuFclrZY7Nv2Sgkpf
        GvDy6VLDyRNxrpIto6xc2ywpKXeiWSbGzGOayqvrUZvNnwc3E+esJMjShq6UAS+JeY1Yiu
        awpMnOfFiQGT4LuVB8OA6L8f9yGHSDJCmUIJRROT07i5bH7PRmwuSI2hXSQLn8cpN9Mm3y
        Tt7O166p00csnFZcbBFTzUMXQHBgC99fwJPfB6f8JcXPR5eyG7VpOu5FXty+bxh2GTOWzm
        1Z5GZCxQHACtkSCoyaJorWGXs9NuOsUEp+chSH9tTUGCs5ljx9Cbch7vx3mrsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1659588798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=CR0IilEjTmSBglJdVE7uE6gZjyN8Yc4w1VrpHAB9SKI=;
        b=RUFzHgnn3guUieZkusMS6aeTqOrk+j6mRtLgiUOnhOxLmz917/MHkEFkRxmHGoZPnQNgTK
        hmC2q6B/AuZS6OqjeFYInWGXVpGC3VQjvcIhhJqp2Xy6LfLhQx67j5m0R5ecN1umN9sF6Y
        eKmkQG1bYOAO+OL30jTnHlWXJyvBlsuzVvOz3noNjpR4JSej34FUdXTr/T693e+PyVx+dW
        QekXuKsYaMdZPpnaPShVAIwz1Xh3ls+kj9mR8WY4j5SgiL+As5acKrsijQKZoSqZpA+lJr
        +44WwUPuQRqXOWbaFIUXLbisL3tXCZESX6Q2gtdk+Iy15fFn9ZHXgkbrnllL3w==
ARC-Authentication-Results: i=1;
        rspamd-7c478d8c66-lg758;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Absorbed-Unite: 5769d0a00ad3aa03_1659588798489_2908946806
X-MC-Loop-Signature: 1659588798489:3535241750
X-MC-Ingress-Time: 1659588798489
Received: from pdx1-sub0-mail-a254.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.110.28.208 (trex/6.7.1);
        Thu, 04 Aug 2022 04:53:18 +0000
Received: from offworld (unknown [104.36.25.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a254.dreamhost.com (Postfix) with ESMTPSA id 4LyxF91s2Xz83;
        Wed,  3 Aug 2022 21:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1659588797;
        bh=CR0IilEjTmSBglJdVE7uE6gZjyN8Yc4w1VrpHAB9SKI=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=Lfu43C+ook7NEcJrRA+sgZLN8yzafbMbSLrolenUTCPndBEiEaGUuYX+GXis54iuz
         2JovFM8Nyo4z527M5I9bk5atJQDtMfBCccdUsms32ysCCZ1aJ6qRJp1NgJRiYUp2KX
         7xWLMt7Zc8M7wJy6ouuDSDfaIIUb516U3oHaARfEt17X5s2WVF7aQMjx03nVLxx7O1
         KG1piapNDZ5MOr5pgI8jdN4uOC+9C/TxxkFDnddvtt//dsXNdwY0WpOfZtfAwsddbE
         wXPuRkfb4nO9yqfo9ekm3zsrHpSKbnwaEXLyApVwrtzjgXMxrDBll04xg31jM7/6nN
         /KKG1mJ7KnjIQ==
Date:   Wed, 3 Aug 2022 21:36:19 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, bwidawsk@kernel.org,
        Jonathan.Cameron@huawei.com, ira.weiny@intel.com,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        a.manzanares@samsung.com, mcgrof@kernel.org,
        linux-kernel@vger.kernel.org, dave.jiang@intel.com
Subject: Re: [RFC PATCH 0/2] cxl: BG operations and device sanitation
Message-ID: <20220804043619.ko5luhppbvcoh4s5@offworld>
References: <20220804045029.2905056-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220804045029.2905056-1-dave@stgolabs.net>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*sigh* Cc Dave.

On Wed, 03 Aug 2022, Davidlohr Bueso wrote:

>Hello,
>
>The following is a followup to some of the discussions around CXL device security
>and sanitation[0, 1]. It is marked as RFC mostly to see if the background handling
>will satisfy all users, not just sanitize/overwrite. For example there has been ideas
>to avoid command hogging the device and/or interleaving scan media regions instead
>of all in one, etc. More details in each patch, but:
>
>Patch 1 adds the required background cmd handling bits. While this is currently
>only polling, it would be good to know if there are any fundamental blockers for
>supporting irqs (beyond just background ops) between PCIe and CXL. For example,
>are there any requirements/difficulties that is not the standard MSI/MSI-X PCI
>vector allocation + devm_request_irq()? I have not looked at this into details but
>it the topic has come up in the past as delicate', iirc.
>
>Patch 2 implements the sanitation commands (overwrite and secure erase).
>
>As for testing, while I used the mock device to test the secure erase command, I
>ended up hacking up a prototype[2] for qemu to support overwrite and bg commands.
>So while the some of the paths this series introduces have been exercised, there
>is of course a lot more to do.
>
>Applies against Dave's cxl-security branch[2] which deals with the pmem-only bits.
>
>Thanks,
>Davidlohr
>
>[0]: https://lore.kernel.org/all/20220708172455.gi37dh3od4w5lqrd@offworld/
>[1]: https://lore.kernel.org/all/165791918718.2491387.4203738301057301285.stgit@djiang5-desk3.ch.intel.com/
>[2]: https://github.com/davidlohr/qemu/commit/64a93a5b824b59d3b547f06f7fbb1269fb4790ce
>[3]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl-security
>
>Davidlohr Bueso (2):
>  cxl/mbox: Add background operation handling machinery
>  cxl/mem: Support sanitation commands
>
> Documentation/ABI/testing/sysfs-bus-cxl |  19 ++
> drivers/cxl/core/core.h                 |   2 +-
> drivers/cxl/core/mbox.c                 | 304 +++++++++++++++++++++++-
> drivers/cxl/core/memdev.c               |  58 +++++
> drivers/cxl/core/port.c                 |   9 +-
> drivers/cxl/cxl.h                       |   8 +
> drivers/cxl/cxlmem.h                    |  65 ++++-
> drivers/cxl/pci.c                       |   3 +-
> drivers/cxl/pmem.c                      |   5 +-
> drivers/cxl/security.c                  |  13 +-
> include/uapi/linux/cxl_mem.h            |   2 +
> 11 files changed, 461 insertions(+), 27 deletions(-)
>
>--
>2.37.1
>
