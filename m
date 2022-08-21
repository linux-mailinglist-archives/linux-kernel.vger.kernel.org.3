Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C4B59B619
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 21:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbiHUTMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 15:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiHUTMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 15:12:38 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4720C1B7B1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 12:12:37 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id s11so11369563edd.13
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 12:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=jILonV086DNQ+KWlOgi6a3UzHTGVyIQ7N2DF/l9R5Ms=;
        b=d6as8TiE4LmDOL120eqrxKyMEZMpLMYZKRTGZ9J0ByyZvoY0XLB/GqMnanObaxp8tG
         Et6snwtFVB3GEt0jNM4JMqVe2BcB8lm4JY2tItXb+W+tLJYgp6qHCj6+POofV6NPgPec
         I/hoJdgZ2LFstLdE4PZ/cg+weAgbGm09rQFGDhCxCcMNGy+Df7n5hT6ZZ4kPFVjFOaBd
         +GjwhLKxtkA4vPUPk1V4wYZW1/FGs5c8CBCvMt8Fcl1PYPY1IgPp8E0ZYik/1mjzC5+0
         Fz2yAWujFXCSsMs7K9Qm0aOa0gI9+8eu6rJcp6zRcesak1GRhlIXN+HkyEaps/oNhvCN
         HcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=jILonV086DNQ+KWlOgi6a3UzHTGVyIQ7N2DF/l9R5Ms=;
        b=Dgcjnmtim7b1kWtKzVTHQzFOxmpoMMuk0uqF5SCNFhObXVfOut6C9HLsJPAHvLnXzT
         Xwa5LOznqwhMuE2OD+s6Sl75WMT8gXhTonKu+HhpxgZEo9fQf9qcYj4Kldjyzf7Ty/EN
         HZ6A2xGgm0x343NpxQW9dblmjKJPc2MFdZu1w9Gu27vSmUApCQ2zaEfxoRAQLFxZxZzR
         nMEYo79QYAwXPMgIMrWvlzhlcDLtKup7A4KHBw5Bdb8wazLyl9FPOc4aK2oO6JEeiSOk
         Y1PEEj+aYdbnts8+1lYUR6P4+Sl6Ve4rDz0RPDR1eu5HTOodTDf6fw2hdPn+HmoA4zti
         Ga3w==
X-Gm-Message-State: ACgBeo3YfAhiNKRAsNwDLJmegF+s4ciRdUODVzTgz0jPJNcwLlzQj+L0
        XswLT3loUsql6nobzzXqwmA=
X-Google-Smtp-Source: AA6agR6jzKOvGqSaReSFOGzi1pxDqEbFCqv6BU5VfB4swj3L7QT90lmf8GbslEdWIeksHK/NQ0XJdg==
X-Received: by 2002:a05:6402:2499:b0:440:942a:40c2 with SMTP id q25-20020a056402249900b00440942a40c2mr13743059eda.37.1661109155774;
        Sun, 21 Aug 2022 12:12:35 -0700 (PDT)
Received: from opensuse.localnet (host-87-17-106-94.retail.telecomitalia.it. [87.17.106.94])
        by smtp.gmail.com with ESMTPSA id s13-20020a170906a18d00b0072af102e65csm5149520ejy.152.2022.08.21.12.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 12:12:33 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc:     Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Keith Busch <kbusch@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v2] nvmet-tcp: Don't kmap() pages which can't come from HIGHMEM
Date:   Sun, 21 Aug 2022 21:12:30 +0200
Message-ID: <8107517.T7Z3S40VBb@opensuse>
In-Reply-To: <20220821054602.GA25754@lst.de>
References: <20220817184519.25141-1-fmdefrancesco@gmail.com> <20220821054602.GA25754@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On domenica 21 agosto 2022 07:46:02 CEST Christoph Hellwig wrote:
> This introduced tons of pointless over 80 character lines, please stick
> to a proper coding style.

I'm sorry for this mistake. I'll break those long lines in the next version.
 
> Also or in-kernel I/O wouldn't it make more sense to use a BVEC iter
> insted of a KVEC if we have the pages anyway?  Or does networking not
> support them properly?

I must admit I knew practically nothing about this code until I met it while 
doing my long journey towards kmap() and kmap_atomic() removals. I can say the 
same for regard to the differences between BVEC iter and KVEC iter. 

Since you are asking this, today I did some research and read code from other 
drivers/subsystems, despite this particular issue is out of the scope of my 
patch.

I also read an interesting article in LWN: "The iov_iter interface" at 
https://lwn.net/Articles/625077/

I may very well be wrong, however I think that iov_iter_kvec() is better 
suited here.

@Sagi, anything to add to this discussion?

Thanks,

Fabio 



