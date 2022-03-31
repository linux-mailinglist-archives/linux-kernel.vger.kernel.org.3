Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A194EDBB2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 16:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237572AbiCaOcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 10:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237562AbiCaOcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 10:32:33 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4392B1D67D9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 07:30:46 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id x9so16858116ilc.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 07:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=l8CekeoQZXHX4U3TiS2vpp4O2YuTCmdU/BDSBQosw7Q=;
        b=2t3SM0cZXUR72lsXD7aWv01f4VUP1+TsCWH1VXhR9gW8eeqvvAYm8IPed6tPPC/+bT
         /wf9r2P3V48ygYra/UM1VT50ENC51HGaz5CRa65IhBEmNu5LJEGBB7CqL0dNZJ++bP5l
         ZuFHQmFFFJgh/P90XI1k0WCdnaV/65iQKBTWubWDoonZK3zxaSLZQXZus5lAGOBhywkZ
         TrV5h5uml6+9t1iFBJ5FnSDBddgz0muYcbWXUBl6LXRAAfpdksB4eK30BIE/mJJM1ZHC
         rmY/8/X0BmT2ei/CA6CADJPhXxCAdFQCskc1lcm8c4RtAGPxzECZY8oM8CNOmAkuRemv
         /OtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=l8CekeoQZXHX4U3TiS2vpp4O2YuTCmdU/BDSBQosw7Q=;
        b=IWWZfV1vqBuOCnIZrdPcyHoq2vYKCYt7eOegnDD8Ycn3WG9WIAqKS/8O4kOh8gQUt/
         1CK9qFdVPOfN57ZLWilYSmOw1ldvV+Bjz+TPD/QE6cElBVqMYVmd4ZfnqHCpoc2nTuC9
         PGi0LWcGktWrXpqazRPV+aU26HG4Zpqwpn26/8HC6sEL3+YTqEXzwbjAvCpI2uGfC54P
         neOqNcrcQTiwOoIc9xr57AFgLF68iDd5ejpRfApcELZAl49IqJYV+47aUV1YLyZ+sAcG
         DOUR6dtwPt3w/n5AykMzOr69mCPmcxQNk44y4LUmKnOLMArdMBIFq9if3O2YCV7zwdK2
         EjMg==
X-Gm-Message-State: AOAM533yBI5Gx0SjZ9hPXoqaTaoA1Txhme5Qyq3zhUW9IghGOdkez0VM
        fdspjOtdoAud4USS8lz/lCH/AQ==
X-Google-Smtp-Source: ABdhPJz25adczaNwDR175aQhqMn4WdHp4yEMllsYZBu8VTCksFw0OQj+38m10GkF9u9YGSPT+0qfJg==
X-Received: by 2002:a05:6e02:1c0a:b0:2c7:75de:d84 with SMTP id l10-20020a056e021c0a00b002c775de0d84mr13381733ilh.186.1648737045567;
        Thu, 31 Mar 2022 07:30:45 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id i3-20020a056602134300b0064620a85b6dsm13883109iov.12.2022.03.31.07.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 07:30:44 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     josef@toxicpanda.com, Zhang Wensheng <zhangwensheng5@huawei.com>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com
In-Reply-To: <20220310093224.4002895-1-zhangwensheng5@huawei.com>
References: <20220310093224.4002895-1-zhangwensheng5@huawei.com>
Subject: Re: [PATCH -next] nbd: fix possible overflow on 'first_minor' in nbd_dev_add()
Message-Id: <164873704446.46490.778795283218997371.b4-ty@kernel.dk>
Date:   Thu, 31 Mar 2022 08:30:44 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2022 17:32:24 +0800, Zhang Wensheng wrote:
> When 'index' is a big numbers, it may become negative which forced
> to 'int'. then 'index << part_shift' might overflow to a positive
> value that is not greater than '0xfffff', then sysfs might complains
> about duplicate creation. Because of this, move the 'index' judgment
> to the front will fix it and be better.
> 
> 
> [...]

Applied, thanks!

[1/1] nbd: fix possible overflow on 'first_minor' in nbd_dev_add()
      commit: 6d35d04a9e18990040e87d2bbf72689252669d54

Best regards,
-- 
Jens Axboe


