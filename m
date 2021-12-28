Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A506480BDF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 18:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236642AbhL1RKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 12:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236046AbhL1RKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 12:10:02 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A730C061574;
        Tue, 28 Dec 2021 09:10:02 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so25147657otu.10;
        Tue, 28 Dec 2021 09:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m1h8141w0K8XLjyoE9KrDpYHYTgv1VRu4YCN8VN6hyw=;
        b=YqBldmZfgQmZ4/aHeJrUSjYR6vhUhHfIc2oez650BNeH3a/vI6eKw1YOInY2wWCrPA
         OhxrV9WuWb5cTPBO7jH/eIVGLjxnPIMBQBZ/Q7zMku2YtqRxBm0z6rAXj2yyBetieMNJ
         SEkB/odu5UXCBHvbd62L0XzEnSaTh9j7s+tpInS4+WxYrBdOiYUAiWM6LcIJyPFhcClJ
         ukSDnvTSO+8zGcjwzPhOGzFOEzMa9bUHlL34dMWavsU0vfnagmcPQ0CY/AgMd/CszKDQ
         CuXiWXf2y/nWGyEBmGUG2gXLVOTBPTQOh5QmEjQ00+w3U4V5i5y3edx2Han1zl3/DJfE
         +yVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=m1h8141w0K8XLjyoE9KrDpYHYTgv1VRu4YCN8VN6hyw=;
        b=IpL6eu7j2biX4NZsPkV7gnSvOpdvGFTQbIMFAbCuR5bd59Wf0tu30ZZ5iPd70IrJTp
         Ay3DmDf/x0lYCbNZgp/ugaK4d/POK1Vc9rMkc8Q4d5Lo62fZNdlPxgQNaW6GhYi/oIk2
         GZvYfmNX9CoIAHb9BRjql35g7HeRESVRsd6UfTRJBZI8RWhCZEpEAEVY2xMqn/bsrrtF
         CS4n+2Njo2EzgsK2bz6EZp96Xa/xUg5nLTHi4ckUPNUDfQAFATGnh/Ef+dxk2cEeVhQx
         I3piPM6J7pr7Esoy9vX/3b0qGvOqbrl7Z3tqAV6Am8tKyrO2D5PvVQqDtL3/H8t4DFLZ
         3vGQ==
X-Gm-Message-State: AOAM531xHozu4JM3bPCyU7+on/wMNEEDYHzEhuBHzTD6aHzhxBhS5M4u
        OU5xnXpy/OHOFJgGA5Gx5/o=
X-Google-Smtp-Source: ABdhPJzlUXwNK9vvQCQzyiUnDakNNFoJSLCSlWqEZjIRiQvjWYga5TpM/71tn7CLO+uiAOA9UTMj2A==
X-Received: by 2002:a05:6830:4a9:: with SMTP id l9mr13202967otd.75.1640711402010;
        Tue, 28 Dec 2021 09:10:02 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bf17sm4073198oib.27.2021.12.28.09.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 09:10:01 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 28 Dec 2021 09:09:59 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] hwmon: Add debugfs register access
Message-ID: <20211228170959.GH1225572@roeck-us.net>
References: <20211227224201.508331-1-demonsingur@gmail.com>
 <20211227224201.508331-2-demonsingur@gmail.com>
 <b8dbcf50-8478-02c0-7a94-ff5b2b04aa2e@roeck-us.net>
 <9b82bdf9-25a0-46cd-cfed-b86f114dc303@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b82bdf9-25a0-46cd-cfed-b86f114dc303@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021 at 06:51:40PM +0200, Cosmin Tanislav wrote:
> 
> 
> On 12/28/21 18:13, Guenter Roeck wrote:
> > On 12/27/21 2:42 PM, Cosmin Tanislav wrote:
> > > From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> > > 
> > > Similar to IIO, create a device directory inside debugfs
> > > mount point, and create a direct_reg_access file inside
> > > that directory, if debugfs_reg_access callback is defined
> > > inside hwmon_ops.
> > > 
> > 
> > Patch looks good afaics. I don't want to apply it now (ie for 5.17),
> > though, because it is getting close and we don't have a use case.
> > If you have one in mind, I'd suggest to submit it together with
> > this patch, or we'll have to wait until there is a user.
> > 
> > Guenter
> 
> As I mentioned previously I have a local patch on top of the ADT7X10
> refactor that uses this. I tested your modifications to my patchset on
> the ADT7420 part and it seems to work just fine. I can push it on top of
> either this patch or that patchset, your choice.
> 
The adt7x10 patches won't make it into 5.17 either, so all that will
have to wait until 5.18. If I don't get a use case by then I may write
one myself, but that won't happen now because I am about to be away
from my computers for the next two weeks.

Guenter
