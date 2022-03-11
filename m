Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CACE4D65F2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 17:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350191AbiCKQVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 11:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241387AbiCKQU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:20:59 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562F71CFA1C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:19:56 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id u10so13679532wra.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n703PiMdH28y8+lrGIdVHry6FOQRwEpTeriwZQDN8lM=;
        b=PBCyV8agNbQ33tQiq+MU01pdv/2vyhWeps1vj+oMWSpaY+Zwj4DisvvIAifV/4MKkJ
         NJ2NIBqIcthufAjjBSAeYhRmy+1mHARJQ8aZqbWnNvCRoL4UAflr3y1DocBlD91MJpAe
         Ot8dEQ7Jg+VPHwQ94EYE8EMQuvTkn8Num0Si2DZNitP/kB1VYOWCOw+maZ5xO+bCv2OR
         oTDtsRF9w3pGkAX+BS7kAWEf+Ei4pPB9XUtoUQOaPzvMdqzCJo3wSXykhgbzOT9jg4WH
         FQzIwIV0gDHgmhL9jkhixEULdkLx2iUHvGgDAEB92XoGUYzFdZl+ONQD11aT5yfzdPjV
         lUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n703PiMdH28y8+lrGIdVHry6FOQRwEpTeriwZQDN8lM=;
        b=sYNNtppJ0KAw1Zzip1ZcdZm7khnamFK6lOjl+f3kDNJXR9WVWuNn6glvzpB92bGDMI
         F6EO5zZ9DH4pAK4MW9/E+zTqsUL8gPbNcudmbudiS8VOrogLZB3JV4f8JsSPThi89Py0
         16yAezWZyXyJErrPQdUG4XTOnu2tbSW4yvfbt2hOeuES6PSB3sSZeIjmbf6EHv/LIDBS
         q2dEHjctME8uvb6bTrMwi2ifGU+DgsUXAgC7yGm1H+c9xPC5cTXXaJnVfc4LGH+kto9X
         gMnP7x3NDPTqh6Ct3dEbTPCxMxJql8UO6kYOvm1zJdNPjUgKiK7b1yXgsCRaS01deCpe
         gizQ==
X-Gm-Message-State: AOAM531vi7GtiOS1vvLEmvC4vFCbvw2bw9A1PsO7/k/x3dx9qWhVor2o
        EhHMwSjmmQM+1/B2o9KlyA7t5Q==
X-Google-Smtp-Source: ABdhPJwzTa35YepRUOfGsy0vO6pw8vrnH3Sck1bav/ru9whktgrIUK1FL634X/kgm+zL5GC5H501tw==
X-Received: by 2002:adf:914f:0:b0:1ed:bb92:d0cc with SMTP id j73-20020adf914f000000b001edbb92d0ccmr7998579wrj.297.1647015594869;
        Fri, 11 Mar 2022 08:19:54 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id ay24-20020a05600c1e1800b00389a420e1ecsm7527872wmb.37.2022.03.11.08.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:19:54 -0800 (PST)
Date:   Fri, 11 Mar 2022 16:19:52 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, christophe.leroy@csgroup.eu,
        hch@infradead.org, cl@linux.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        void@manifault.com, atomlin@atomlin.com, allen.lkml@gmail.com,
        joe@perches.com, msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com
Subject: Re: [PATCH] kdb: Remove redundant module related references
Message-ID: <20220311161952.thugdrwd6junr7ib@maple.lan>
References: <20220307174741.2889588-1-atomlin@redhat.com>
 <20220308105203.2981099-1-atomlin@redhat.com>
 <20220309120640.uumh46n2l37jaddf@maple.lan>
 <YiporeSIrkFg/YS8@bombadil.infradead.org>
 <20220311154723.ezo3wvgg4puu2zk7@maple.lan>
 <20220311160153.3k2avq24mpjyrdpy@ava.usersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311160153.3k2avq24mpjyrdpy@ava.usersys.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 04:01:53PM +0000, Aaron Tomlin wrote:
> On Fri 2022-03-11 15:47 +0000, Daniel Thompson wrote:
> > On the whole it doesn't really matter much... but landing the
> > independent parts via the normal route for kgdb code reduces what I
> > have to remember acking.
> 
> Hi Daniel,
> 
> Any thoughts on this [1]? Unfortunately, the wrong In-Reply-To was
> specified. So sorry about that. I will send another iteration of the series
> so that it'll be easier for Luis to apply to mcgrof/modules-testing or
> mcgrof/modules-next but after we have more feedback.
> 
> [1]: https://lore.kernel.org/lkml/20220310102625.3441888-2-atomlin@redhat.com/

As above. I would rather not have to remember acking the header
changes as well... but it's not like the sky is going to fall in.


Daniel.
