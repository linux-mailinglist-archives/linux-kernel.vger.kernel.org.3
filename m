Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537A152FF0C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 21:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344772AbiEUTqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 15:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiEUTqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 15:46:07 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CE715827
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 12:46:03 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id h9so2234888pgl.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 12:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zX5ok7BJ7D+wfGwmQ8/pQkeL6pnnmgUlA3fKtsver3U=;
        b=WOzdn6iO4OrpBAgQhS+QhjwGJ1+p1jNil1znlCHh1oyStS/cCmofFee1gCmgKV00FQ
         SQX1GEC0F98jIatP1VV2t9F04XF9Q0nSe3EsuhfSA/AI2/IVqwm1KtF2pW0KDmnm3WGI
         VW9Ttok+oxGHkkzwgPg3/81BJB2YmSEiraKkE6xmPNa2oxxNHsxAi5cQ7kIgXnPBpF7q
         9gCJIl7jVbqRkgdD490aNOQNlvhhyWa8SndtLn53/sXqiCK9+HfjkyaFmKmXrNJNhjtJ
         O8LxeCRMpP16/ABpUxMUbFQiEEYXpC/MmnkMykxcJMBZxd4HhkwPa/vneb+YOPLlLKqt
         I/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zX5ok7BJ7D+wfGwmQ8/pQkeL6pnnmgUlA3fKtsver3U=;
        b=GOkOiY987/xcX/jsDDFqYW77psVgYnppL9YeX53OLlAvOQGyVEr8h55gOht64g0oAg
         4z/YVEWzzfuF/fHspTXoht4NcxrmBOm1fTMYFuZkTIXnDpc03LB7GwqXrAdAbR8/iQxH
         Fr2rH3OWhnBYP5HzQP/dvwklxn7lNSY7u9FTE6RFizZlvYQcPQrBMqnv4867v6Ojh+Dm
         o6yXkq/RQCviVjQyblFRNV69rQNvfRrXkeflh26W128HP77EiXKPpD6g5U7ff2k5Sl2c
         78fGTgpb+rF2moYJE9GY4pSESPpYoYjpryN4m29zwC9FYmLaYEE0uVN71EwQs4Mz9bWg
         cGoA==
X-Gm-Message-State: AOAM530v/TKhZaAIDmd909JWie0Aws/4lwBLd1mUFdqMvCZE7lvAMSIa
        E66GCz/t3PWFkIV5V9/csOVx/Q==
X-Google-Smtp-Source: ABdhPJxbcUpunxaw0PstfwrdemrAznw9JU57xGuOAyg7DM7aIFDIXAliI8Nxt6ZJIbS/N6XC+EMeow==
X-Received: by 2002:a63:1e0c:0:b0:3f2:5b19:24d0 with SMTP id e12-20020a631e0c000000b003f25b1924d0mr13900376pge.562.1653162362867;
        Sat, 21 May 2022 12:46:02 -0700 (PDT)
Received: from hermes.local (204-195-112-199.wavecable.com. [204.195.112.199])
        by smtp.gmail.com with ESMTPSA id k11-20020a170902760b00b0015eaa9aee50sm1955491pll.202.2022.05.21.12.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 12:46:02 -0700 (PDT)
Date:   Sat, 21 May 2022 12:45:59 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        netdev@vger.kernel.org, mcgrof@kernel.org, tytso@mit.edu
Subject: Re: RFC: Ioctl v2
Message-ID: <20220521124559.69414fec@hermes.local>
In-Reply-To: <20220521164546.h7huckdwvguvmmyy@moria.home.lan>
References: <20220520161652.rmhqlvwvfrvskg4w@moria.home.lan>
        <Yof6hsC1hLiYITdh@lunn.ch>
        <20220521164546.h7huckdwvguvmmyy@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 May 2022 12:45:46 -0400
Kent Overstreet <kent.overstreet@gmail.com> wrote:

> On Fri, May 20, 2022 at 10:31:02PM +0200, Andrew Lunn wrote:
> > > I want to circulate this and get some comments and feedback, and if
> > > no one raises any serious objections - I'd love to get collaborators
> > > to work on this with me. Flame away!  
> > 
> > Hi Kent
> > 
> > I doubt you will get much interest from netdev. netdev already
> > considers ioctl as legacy, and mostly uses netlink and a message
> > passing structure, which is easy to extend in a backwards compatible
> > manor.  
> 
> The more I look at netlink the more I wonder what on earth it's targeted at or
> was trying to solve. It must exist for a reason, but I've written a few ioctls
> myself and I can't fathom a situation where I'd actually want any of the stuff
> netlink provides.

Netlink was built for networking operations, you want to set something like a route with a large
number of varying parameters in one transaction. And you don't want to have to invent
a new system call every time a new option is added.

Also, you want to monitor changes and see these events for a userspace control
application such as a routing daemon.

