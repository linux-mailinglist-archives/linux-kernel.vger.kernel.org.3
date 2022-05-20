Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225A352F137
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 19:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351995AbiETRAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 13:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242208AbiETRAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 13:00:09 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF1217CCB0
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 10:00:09 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id v14so7355017qtc.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 10:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fFacJbvwa5BeiY3szVOg+2bHWvSVuVrSCav3PMs3Wy4=;
        b=FTtqHS4Ab3DM4iXG5smV6wqAV7NigY5YOsrNfdM9EDqDL5th5wGo+wZVRy8FzYswDT
         SDGetT+iY1qj8QP7mFHxOIrcrxoTg1NqhzsPapXSFVu5aIeW1EAtipIjCmrRcUz29+Bf
         hWHp4zj09YNJkFNnFMW8OiKSexYuzZGbIkol9548EZJ9Rf41Y30NSDUob2I7XkCeZl4O
         pfSVSMFREIQS6MrbI490t5eTt2FG/rgno1k87u3e7A+WECLqsnH9niksYJaD+/E5R528
         P/0JMNG2HVIKLA4xI7BcX1v1jJ5kDukehFUYmZ7xykFZntaS5Z58ilBHB5ZecS0fTxju
         EZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fFacJbvwa5BeiY3szVOg+2bHWvSVuVrSCav3PMs3Wy4=;
        b=AsT21lnR78uprTHDRU+ffdCQsGav3EdKbytEUU66TkJwhGrpv/N/4WkqYzIxDwrKHU
         v4XOS6Hr/nyfGpj2f+JQ299NK+MSJkyLeSsK/04N3/BXYYakBQ8HiF43EcUTSWtRiWyR
         j+YZeGbB+48uHAxzxbNrMX6tsOetMRS1uRyWAEIk+wBJqAIBSRXqVl9iJjugXTY2peJZ
         VtPwhfhpS0imjrKG1uuNKNfQrOSswqXMTWes2ATsJTcb3tTzp4157RCgZUF2y0QxXq1c
         rI/ZBXDd9Hsk/nwOPVPkA/F0QoV1EMh+OgNabkmdGg/xBGkd/CLdNLNiDXXw4gll/fI7
         3sdQ==
X-Gm-Message-State: AOAM531t5QKa7qHDK1SnYEFt1mL1mKVw6MtTnugPT62TRsdLvCI+CNIk
        SHmmco9ZcvlMYkYNOZHKCg==
X-Google-Smtp-Source: ABdhPJwJLVP/OySs/WRd/Wh6kqhmG3bqXMDgdLqLgevH4DAll8yOHHXdgwbOB6cDskW54cnK9Iwx3Q==
X-Received: by 2002:ac8:7f01:0:b0:2f9:1c7d:c68 with SMTP id f1-20020ac87f01000000b002f91c7d0c68mr3619868qtk.504.1653066008225;
        Fri, 20 May 2022 10:00:08 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id k12-20020ac8478c000000b002f3d7c13a24sm13041qtq.4.2022.05.20.10.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 10:00:07 -0700 (PDT)
Date:   Fri, 20 May 2022 13:00:05 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH v3 2/6] mm: shrinkers: introduce debugfs interface for
 memory shrinkers
Message-ID: <20220520170005.a3dlxk6a2qbrjdoq@moria.home.lan>
References: <20220509183820.573666-1-roman.gushchin@linux.dev>
 <20220509183820.573666-3-roman.gushchin@linux.dev>
 <d938e52e-3704-d095-cafe-a6218701896a@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d938e52e-3704-d095-cafe-a6218701896a@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 06:58:12PM +0200, Christophe JAILLET wrote:
> Le 09/05/2022 à 20:38, Roman Gushchin a écrit :
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 3fd7a2e9eaf1..5fa65a649798 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -733,6 +733,15 @@ config SLUB_STATS
> >   	  out which slabs are relevant to a particular load.
> >   	  Try running: slabinfo -DA
> > +config SHRINKER_DEBUG
> > +	default y
> 
> The previous version of the serie had default 'n'.
> Is it intentional to have it now activated by default? It looked more like a
> tuning functionality when fine grained mangement of shrinker is needed.

I think having this on by default if you've already enabled debugfs is smart -
it doesn't add runtime overhead, just a bit of code, and things that make the
system more observable are great to have on by default.
