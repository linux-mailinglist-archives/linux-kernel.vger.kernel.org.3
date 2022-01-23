Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C928497086
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 08:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbiAWHnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 02:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiAWHnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 02:43:14 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83664C06173B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 23:43:14 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so13308006pjp.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 23:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K5nXQuoXfpQ5nXhfs+AzvDvp+MXS3PPaAvbJII5i9wQ=;
        b=qBtXY+eTBCL7UigNPBDg2Zds9N10oaeGEP15IMYGw6Ze5E5htvg/BvUadfPllxI2x/
         T6LjyhaqnIImpt2ww6tZ+eDrAgjalOIk3QdBkucKJwz/muy4QVpNFicle6FI5ZPn1Ejm
         VbXoiJ/OQ+IAI5tjdIMbxDnSOtY2pVUZ2eL5Ok+bCSdfMKj2N9HtSv95VIKJWrk6t/YV
         4fS5mCVLSebIw49DYSqu43g2mECyN1aBVcNgmr5row2GZo+SaniTQo4KhG8HtbowXycD
         Nc3lU+WYbimxqNvlutTS8F4U8Gtfh9FxSJzgwLHe/8nRPomFPxNkvfxdBuuU/JsWv1j5
         sfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K5nXQuoXfpQ5nXhfs+AzvDvp+MXS3PPaAvbJII5i9wQ=;
        b=W/LpumYYpBmr4cY9PzvXvJnDGUaaCD0aUEK0GLtTfjWLo/yLBzqURkIiv4OJQoeR1L
         lRGXhGQFLTiuTOOq7PypfnYkeXdtn3oK8KfKVGZ4hyGFU8noWDHYDiRk673POwNB189r
         tTwSxBmj/wrd9yFk3XI00OCe1lvkNHFoA96GkNrRR+PRqNProVi2XeCFFMr8o83OBRD4
         1iM0bcaPBMk/8ORYW/T2fBbuVzQx0KmfYTH1e8K8Am3NnxBprN3p3A7xbfVGW+nEtYiF
         nMDUgpbQaLVGBPvW8eR8NgpMrvd72c9wYNHzU/49Fn8lWc4YxH0yPjdd9mTkUpi1bmfi
         7Z+A==
X-Gm-Message-State: AOAM533Gjii0ntFGQ7KyepzZlBOlVisVZwKHR+H8pVYCKNEvsEALoKhM
        XpkGQ8MPY1cVhqGQn3UdSMM=
X-Google-Smtp-Source: ABdhPJyG5Ebo9L4PlWzO6aM75I3S+4SJgYgiB9wM5Od+WHLQNh+48uDQLPe2+q/UrRIduc2ZllNhXQ==
X-Received: by 2002:a17:902:d502:b0:14a:6d74:7fed with SMTP id b2-20020a170902d50200b0014a6d747fedmr9747850plg.23.1642923794010;
        Sat, 22 Jan 2022 23:43:14 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id d14sm12583677pfv.189.2022.01.22.23.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 23:43:13 -0800 (PST)
Date:   Sun, 23 Jan 2022 20:43:08 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, realwakka@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] staging: pi433: validate min/max bit rate settings
Message-ID: <20220123074308.GA79751@mail.google.com>
References: <20220118193422.GA3155@mail.google.com>
 <20220118230312.GA4826@mail.google.com>
 <20220119060400.GL1951@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119060400.GL1951@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 09:04:00AM +0300, Dan Carpenter wrote:
> I'm fine with this.
> 
> Acked-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> But please do add the note to the TODO.
> 
> regards,
> dan carpenter

Hi Dan, 

Thanks for the Acked-by. The TODO note was added on 0/3 of this patch
series:

https://lore.kernel.org/lkml/20220118230555.GA4961@mail.google.com/

thanks,

Paulo Almeida
