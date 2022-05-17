Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB6B52A584
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 17:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349523AbiEQO7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346439AbiEQO7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:59:53 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A7E4B42D
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:59:51 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id eq14so14551061qvb.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tr4AALZAcgwN+FDcDi87udLeLPWs7ZAJ5eWXrFs/jlw=;
        b=lXoa1En3yZsvkJXX4fuc+7NHLvgNe+4aH70ouZjesRaJiFMXxX3QG3dsf1t5fkrHcb
         Q8gmODYofe2MNMy1TlXekQuey0cpzxYl3vDW46FRA52AmehrCMEYrd4QWaOy8MeNpl7n
         r2yRQaaRg1vKoHAskReKzSNsHzUKAFzqElkPIEBcZy3mlGI3b6d3rlaY5P12JlQs7UWd
         QLNWlpQ27uK+EAd2OXnozD8WszrLY7zYOUN/aZzWwDPhI8oQerbmRCZqrKlH5G+DbRRC
         rv7+mMxfFlLS1KzK4rWDUMW1nZocWhEwhzR9/aOyS48LCiph4jdfVp12q2437zUeTfhE
         E0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tr4AALZAcgwN+FDcDi87udLeLPWs7ZAJ5eWXrFs/jlw=;
        b=uw69aB0+sHA9N2urY8y+BXE6prrOSvcMk+maEzX7o6Z6LNJga79Vx1SQbpaPhbZ/SV
         vi3T7ucJHDcxXTRG+A1hbKHj16v+MGgxNuMqIKJd9p6DqU/DMF7guH45KVfAQXVq1l8P
         yiD2o6J/HnEjVamQjVObCSQ+2RUNAlwGFbbMyCk7I1ZXZEWc6G6nf3gHv6eCf3c5ovpd
         jB2Q8wZ1BtacyUgs00ID8x1Ic8Vz045MQBRQ++TpeKB6RB8wKe5wYueazYycWDduNpvz
         r5AxCAhZmlYbvDCeuJqA/UWHBvUvh0cBg912xVxVI+OZbzMJRQYH76/SjSGTh58C5ib/
         aRLw==
X-Gm-Message-State: AOAM531t8L38MpIoRJVN8KfQAygk/pQjKtPU+1W/UOKuwQ2HVwiN9osy
        QWg3mZP2ZhB1KH24GwET1KPlHQ==
X-Google-Smtp-Source: ABdhPJx0troKsku15aanl/7FKxHDc5w10XHBWKlnQ8Fmx7m1X3jRjlIfgLoQRfI9MNsqxTicoEk4/w==
X-Received: by 2002:a05:6214:27c2:b0:45b:9ee:7310 with SMTP id ge2-20020a05621427c200b0045b09ee7310mr20771589qvb.85.1652799591107;
        Tue, 17 May 2022 07:59:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id 16-20020a370710000000b0069fc13ce1d7sm7735790qkh.8.2022.05.17.07.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 07:59:50 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nqyft-0084Ur-Sq; Tue, 17 May 2022 11:59:49 -0300
Date:   Tue, 17 May 2022 11:59:49 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     longli@microsoft.com
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 05/12] net: mana: Set the DMA device max page size
Message-ID: <20220517145949.GH63055@ziepe.ca>
References: <1652778276-2986-1-git-send-email-longli@linuxonhyperv.com>
 <1652778276-2986-6-git-send-email-longli@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652778276-2986-6-git-send-email-longli@linuxonhyperv.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 02:04:29AM -0700, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> The system chooses default 64K page size if the device does not specify
> the max page size the device can handle for DMA. This do not work well
> when device is registering large chunk of memory in that a large page size
> is more efficient.
> 
> Set it to the maximum hardware supported page size.

For RDMA devices this should be set to the largest segment size an
ib_sge can take in when posting work. It should not be the page size
of MR. 2M is a weird number for that, are you sure it is right?

Jason
