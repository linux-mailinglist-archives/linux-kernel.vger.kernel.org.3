Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808B859E41B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 15:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241255AbiHWNKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 09:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238281AbiHWNJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 09:09:47 -0400
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02457E026;
        Tue, 23 Aug 2022 03:11:14 -0700 (PDT)
Received: by mail-pf1-f178.google.com with SMTP id f17so6860729pfk.11;
        Tue, 23 Aug 2022 03:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=6cz2LwXnYJOLYd61Se+LQLyoxLetDJDlLmQ9IRtJXFk=;
        b=UboNgpxV1kT5Bjd+Fj9yjcjx4kDl4eEJq2D6RzW0KFtgfpVh6GC4db5qsznaJOn1uc
         +IJJDBDpRAx3nGK2Okd/6uRPmByiDsWbwBaNlHDHBEF7HCSd9YDqxexZmvZzQwTyRvM1
         InBKEhfsRHcX+V0tve0R3qPvETYns7RmZG5V9/V/CiG3xfOgo8TXvrLIr730S/pxv8RO
         iFB2SxGEKVQEji8JfVou9Dopqf0Rc0RQY7HgasVGWPJeHoEOe9eJ3RcLdMil4GM/ucTm
         vzqzJ1qtli8gZXxuhUREomOLJC8uEJjHYDsEs7LOuX4EsOnZyZK3882zGwnqnnvt/Liw
         pIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=6cz2LwXnYJOLYd61Se+LQLyoxLetDJDlLmQ9IRtJXFk=;
        b=HmClqmUr4yrMgNgRavry2RgI4BbZm6PzOe/9ZUF4YcjrGPE7R1zDK0TL+1eQQ0MCSE
         PKEhImpmQUhDDvOAKIiB91mknzoxD/WOojZXCGQdPi69J6hcp5V0pty9nu9kxM/WzCfn
         hjsyVTmafTC41u6cJFlmEzy+Jz8wnwRxBEiqBpV3+pWM829vp3ilh7Q3tpXQdZgKU0c9
         fFAPcNSStn6tKV6+LKmhf4/GA+cWSH25d1z4p1HvqEV4knVMouDwYKxmKZkB+aUkuzEd
         yfJDD5h9NxRtlWEFmO9U7S+38HhXF9GgR0cMU3h5h0FD6MXZ1xC02YVQ7/vjROJdOtRF
         yjdQ==
X-Gm-Message-State: ACgBeo2ktldLX5sVXqFjW1Lu+DjWRIS9/yrKV1xiVfrDXNb1s3WCLKVS
        6pqKT1t+xR7vokXjoOdZ44I=
X-Google-Smtp-Source: AA6agR6+gV64bMCZkfhFjFnwJCwoGqtEemCF5u67XouDXNb70rab8m97StWON1OgwRX6hcY/+SBL1g==
X-Received: by 2002:a63:c5:0:b0:40d:d290:24ef with SMTP id 188-20020a6300c5000000b0040dd29024efmr20172457pga.141.1661249317084;
        Tue, 23 Aug 2022 03:08:37 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-56.three.co.id. [116.206.28.56])
        by smtp.gmail.com with ESMTPSA id n15-20020a170902d2cf00b0016c2cdea409sm3578195plc.280.2022.08.23.03.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 03:08:36 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 9CBA710113A; Tue, 23 Aug 2022 17:08:33 +0700 (WIB)
Date:   Tue, 23 Aug 2022 17:08:33 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jilin Yuan <yuanjilin@cdjrlc.com>, jirislaby@kernel.org,
        colin.king@intel.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial/jsm: fix repeated words in comments
Message-ID: <YwSnIYalaRCGggTA@debian.me>
References: <20220822121457.21004-1-yuanjilin@cdjrlc.com>
 <YwN09jVOF4WKw4yZ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YwN09jVOF4WKw4yZ@kroah.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 02:22:14PM +0200, Greg KH wrote:
> On Mon, Aug 22, 2022 at 08:14:57PM +0800, Jilin Yuan wrote:
> >  Delete the redundant word 'way'.
> 
> Again, not redundant.

Hi Greg,

The original comment means "The assumption is that the flow control
should have stopped the way things are flowed, before the flow got into
the state that some data have to be dropped.".

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
