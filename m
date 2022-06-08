Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462C0542F74
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 13:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238345AbiFHLvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 07:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238098AbiFHLvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 07:51:14 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2941836309
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 04:51:12 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id p8so14661492qtx.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 04:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X4i2wcMbj/iWDHa3EccSTYi9vrb0LsIcyhzTI3HD25Q=;
        b=gsR4szaWJqjvWE20hC5hdfEdaxUcjxcYJWQqrstzu4xxiTmXOv1uhEqH0Okl+ii3Ck
         Lxef7EMPhgXETK+39Oomq7CiHlc9QXAZ9Q3min+qE8uvoxeAHzNxYWnvSZ6d5dGx9QUa
         sA3NRfIvZxYWbZI9xNZMXnviqL0VAlBULrWwqYf8avL3S7es7vDW2mzqTTlwvH8ibOe4
         +HkvVFr/RHlpoe+jaKSCsAmNTp8XoLAfDusH+jQPmjWGF6HGX3NFx4xovfK/EEHQ2/x+
         JVqwFibZxcwmbq2gu2XmaZ48HbBclMXCQEEIsE8/FrM401B3QryTk3eoboK04USp54o0
         IFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X4i2wcMbj/iWDHa3EccSTYi9vrb0LsIcyhzTI3HD25Q=;
        b=jCyPEQt5JhhXYD6glyMCPRRrymEnE31iMLJjoq0+uapPWvRHauaVOljh8HGHS+7FOu
         BTvdI+S/toql9o6dyn/H+q/tulhl5vGvzqO/kxyGvUdvEh1F9TMibD0+H50hybxtKBWT
         7J5KNRGs9ulhw43Wwim5V9crYnjXyQaSqptgXlLSiDVXr2JDhdmlCD5AVMVqV0WH2CdV
         cbhij7OtgMSj7vd7skARVxAfARQOwQC7v4s7D9v0TjY9T46dLCNiqvfI1y9zHwrvDCq+
         kBWMapZcJkWkGxllQ8Y8gRLAOMNoTieegZ1Psku63IgrsWhhWJ7pXZI3tsxXcVyunxTs
         wmMw==
X-Gm-Message-State: AOAM533NPIEbk9seij5ef3jc2kA4PhbbuerCgpV5an6oV5RPF/hoRNQj
        hLj2oBPYNmeWZygABxw4x2FYqw==
X-Google-Smtp-Source: ABdhPJyZ2SrePTFTfrAgIOolAeN1EAiF69BUfge2N/rLjt5z3WvnFKKO59sV3Ew1Izh2kefnWEK40A==
X-Received: by 2002:a05:622a:11c5:b0:304:d8cd:2058 with SMTP id n5-20020a05622a11c500b00304d8cd2058mr24463295qtk.324.1654689071139;
        Wed, 08 Jun 2022 04:51:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id r14-20020ac87eee000000b00304ee3372dfsm5188546qtc.45.2022.06.08.04.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 04:51:10 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nyuDN-003ehg-Dq; Wed, 08 Jun 2022 08:51:09 -0300
Date:   Wed, 8 Jun 2022 08:51:09 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     Yang Li <yang.lee@linux.alibaba.com>,
        Leon Romanovsky <leon@kernel.org>, kaishen@linux.alibaba.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] RDMA/erdma: remove unneeded semicolon
Message-ID: <20220608115109.GJ3932382@ziepe.ca>
References: <20220608005534.76789-1-yang.lee@linux.alibaba.com>
 <ef94d5de-da12-a894-8ff3-af7ecf9d568a@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef94d5de-da12-a894-8ff3-af7ecf9d568a@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 11:36:07AM +0800, Cheng Xu wrote:
> 
> 
> On 6/8/22 8:55 AM, Yang Li wrote:
> > Eliminate the following coccicheck warning:
> > ./drivers/infiniband/hw/erdma/erdma_qp.c:254:3-4: Unneeded semicolon
> > 
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> 
> Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
> 
> Thanks.
> 
> 
> Jason,
> 
> BTW, are this and other two patches for erdma posted today parts of
> the static checker reports which you mentioned in [1] ? If so, I think I
> should re-post the v10 patches including the fixes ?

Yes, and I would wait for a week or so because this is just the first
day.

Jason
