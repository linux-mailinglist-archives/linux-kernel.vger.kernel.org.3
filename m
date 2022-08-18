Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47F259826E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 13:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244455AbiHRLp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 07:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239197AbiHRLpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 07:45:55 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E4F248F9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 04:45:54 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id k16so1418872wrx.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 04:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=fVQ+WBq+5u751FInx0j8YvBG1z0BYpuxlDZgTdqDruE=;
        b=fEeweDM6QRg7T/xML7leLYtuQVKINowVaB/8lOhAg6dHO4eb7iueoG2eJSoOZzfoOr
         tS/LDT1eGMRlCoDD9hVq3RZ3VuxvWNOGo9kkKP6WkoX5w7sBZIFN0w7pLYubU6uMNZoF
         VcCKmVrvtqomW+liV/qGcc8obdBBYriGN/3M+D3ojoWsDi7a2/YkBjvI3YELW/73uOdf
         b07fWWBAA8+OsPcjRJOQx/amSZejV4nGpYb0QUx6nNkdKlTbIqhLOPpQSs5ZRKw4cba0
         gUfBlmz9YWV6xxNp2lnWbCQif/HSpKe3vwjYwh1fmKFQiGSUTi9LzLqTasrm0nv8ucN8
         kUNQ==
X-Gm-Message-State: ACgBeo2MJxj/SZ2+e/gHh7zBt6zCTL9xbwmgpAXzJnxaxXU1613s22Ny
        nl91ld6nS4jytLJ1kOheLdzr6V7Svg4=
X-Google-Smtp-Source: AA6agR7qghW7GIkoW61fQp0fdJ8NJ6+k3Fz3ev/G3v9kBwsfSN5qSHhfFc5dqUJe9tnogfQlnAeOWA==
X-Received: by 2002:a5d:40cc:0:b0:225:26dc:938e with SMTP id b12-20020a5d40cc000000b0022526dc938emr1471492wrq.297.1660823153415;
        Thu, 18 Aug 2022 04:45:53 -0700 (PDT)
Received: from [10.100.102.14] (85-250-24-41.bb.netvision.net.il. [85.250.24.41])
        by smtp.gmail.com with ESMTPSA id z3-20020a05600c0a0300b003a5c2abc412sm6482523wmp.44.2022.08.18.04.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 04:45:51 -0700 (PDT)
Message-ID: <c0d5e4c2-512f-3d6e-b555-8a87b1be1db5@grimberg.me>
Date:   Thu, 18 Aug 2022 14:45:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] nvmet-tcp: Don't kmap() pages which can't come from
 HIGHMEM
Content-Language: en-US
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Keith Busch <kbusch@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>
References: <20220817184519.25141-1-fmdefrancesco@gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220817184519.25141-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Fabio, did you run blktests?

The simplest thing you can do is:

$ git clone https://github.com/osandov/blktests.git
$ cd blktests
$ nvme_trtype=tcp ./check nvme
