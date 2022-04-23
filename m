Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F86350C5D8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 02:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiDWA7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 20:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiDWA7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 20:59:07 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64FD225289
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 17:56:11 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id kd22so2432856qvb.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 17:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VoXvIeqAbmOIw8MPtifiiSU52O9NLhujq72iuIkL/pQ=;
        b=VN1VG1wmBwvFxp4RPfHBPhTPXmDyYQiCmA9iJfE+mgzPibnuv2zEF4b+525pX/HiLm
         XaG9K7A5NYqZxVwtuXpatasdGzcfJ5WauI2qRb1ReDzjwkUkmgNQ6irzVS4mUHOx03ZR
         R6/vP7a2Sw3QfrgwEciuB1p1bud5hqKVRmhxJiEnhsN5prJG5f52aouHCduUULhsT/rv
         EoqSEQcee+zLWi/qfA9XHjdVkhSJrVilbaldOCp/BNtmvfJoJcEQeU6YsMq0KlI3u3CR
         tuIFAQGL33Q6/vUcKpnUmTeHnBOgAfJTZItBJHqQTLgI8mWB+JTHTnG6loiXb2FEzVw5
         ye+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VoXvIeqAbmOIw8MPtifiiSU52O9NLhujq72iuIkL/pQ=;
        b=vvyfPSUmaD02u6oqVlXEny/UweHytMtL1PxtH/84bsoBY8ALPkIRjPjvJVJI0ZMf2J
         AHfetX1tknZb1+wTRkzZzZF+91TJHTBcI4arR/FaeIJ7Y88ZXU8F1wV74yCJQaR9ktQN
         4Fbh2+fyCaR3Rv46cbZs3zhtllXqhVdbkI1uJm/3g8+IuwLO8MlQn532xU1aM2B0fnf2
         a1PwjeJ2I1S6+3ghbVwvwEYSQCuFdArbIv+mX/gM5yDKC9FLkdBMxHq+BF4K3NU39gOy
         ffRusQExcc0eMOe+21o9WtqBIS8Mul3Yfs8FLnfIQXUQ0c9GYKePnSgwHp0KkeL4N8S/
         D9gQ==
X-Gm-Message-State: AOAM532B6KQ5hJSWlbFE4foMvedeIl6EhetYXR++3YoPN19vy7mN2/Rw
        gNc1zPqZ3tfAfZ601lznc1N24g==
X-Google-Smtp-Source: ABdhPJy3Gor+up+vdFVQl37njOan+NvWWBlSTjU5FXP+S77AJ12gOqugu5s/TSwOs1rr6XqF48aRGQ==
X-Received: by 2002:a0c:c404:0:b0:431:31c3:3d15 with SMTP id r4-20020a0cc404000000b0043131c33d15mr5523691qvi.116.1650675371094;
        Fri, 22 Apr 2022 17:56:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id f186-20020a379cc3000000b0069e82c4d8a1sm1650037qke.80.2022.04.22.17.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 17:56:10 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1ni44H-008OZg-Oh; Fri, 22 Apr 2022 21:56:09 -0300
Date:   Fri, 22 Apr 2022 21:56:09 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Cc:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] RDMA/rxe: Remove useless parameters for
 update_state()
Message-ID: <20220423005609.GW64706@ziepe.ca>
References: <20220412022903.574238-1-lizhijian@fujitsu.com>
 <b3c747ed-1a87-896b-d95e-35fd2a80ccf7@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3c747ed-1a87-896b-d95e-35fd2a80ccf7@fujitsu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 01:07:46AM +0000, lizhijian@fujitsu.com wrote:
> ping

I'd like to see some of the people testing rxe look over these, at
least until we get rxe back to being stable

Jason
