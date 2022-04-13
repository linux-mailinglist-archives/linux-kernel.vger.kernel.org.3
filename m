Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3804F4FF340
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbiDMJUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234210AbiDMJUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:20:23 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28F052B00
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:17:47 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b19so1652757wrh.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QevIppUHzFszJ+svmEliy9enENifrM8XKuXo2Lypfb4=;
        b=kL91AK127SudV0s3BmM1tHsiMRH85Wt5P1sQ6+1rvUsVr8tAMroIj8SN0fDYAxFWLV
         Emr94FEzCSUxVdi7xj3lZU+LMpABV6hPpCknYFMrDmcNMIFEZj7dcGG6snd4BeMnHz76
         qhiPunciB0W293+xW4BimGSihgpa5v1vEsOK21c6aUQWhS0r+j0KsAdabzCqk598sK7a
         simNaOGNWdomZDFBECfsCD8SKld6TB0/9JY0p8VLaVPKDJzkZ6Hh7xaPeLEsNEHo+h2T
         QTgnm3swhzvCvu0Qi92J7nNL8wsMKFigdarmicY6BR1tehJGz/VrLPFptoFOf5rwrHJH
         GnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QevIppUHzFszJ+svmEliy9enENifrM8XKuXo2Lypfb4=;
        b=AcioX7FSF3/UJPOvxvq5Q6tuRHnlJP9+aEOS/sHPMRr2RaldtmJCckZOZJXujiY8uI
         m8CsyIiHgmyISjxyR9/hqBHw6q1OyFIqdLHTz09F7x+/bCsB/HPEXOrf6lalSWGxsnUH
         s5ijJ4EVzixnUScZC7TaqkS/j1nncqAhqGbUJrN1YtNcQYieYLQ2dYzK8aPqEJZNSidY
         cjRuO/8VgHTXI+cUNjFs8/0FuiHm+wM3/xc2DtloH8iIW6Y2qYR4v6vt9FZgmhNpW71H
         WfMP4uIXZCngHt/hxt4q1iKyuTLiUK5GzTBf9EvN1QIFLHbfsW7f6FYQhvFbSmgPXwVv
         MSLw==
X-Gm-Message-State: AOAM532VKGPweuel2qnCooDwuMmZknEsk2pGs6ifedpAXG33zebUn775
        RQhDpdFJjI26uYz1sb2/Yq14Q26YNrgMfZY+ZlgZHA==
X-Google-Smtp-Source: ABdhPJxI7FAkeF9HaZmGrVRQ0z4l9fIkTFq/AM1woxFHWDA6N4y713vIH4IlVLDxWVkvqQ1Qe9zRNTUWIVZvHgEAn5E=
X-Received: by 2002:adf:e84a:0:b0:207:a697:462c with SMTP id
 d10-20020adfe84a000000b00207a697462cmr11117743wrn.312.1649841465722; Wed, 13
 Apr 2022 02:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220413030307.133807-1-heiko@sntech.de> <20220413030307.133807-13-heiko@sntech.de>
In-Reply-To: <20220413030307.133807-13-heiko@sntech.de>
From:   Philipp Tomsich <philipp.tomsich@vrull.eu>
Date:   Wed, 13 Apr 2022 11:17:34 +0200
Message-ID: <CAAeLtUB=FTTD32j6AP7Mv1DsaP3VDUkZcHAAmB6i-iD+A4zvmA@mail.gmail.com>
Subject: Re: [PATCH v9 12/12] riscv: add memory-type errata for T-Head
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, wefu@redhat.com,
        liush@allwinnertech.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, drew@beagleboard.org, hch@lst.de,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        gfavor@ventanamicro.com, andrea.mondelli@huawei.com,
        behrensj@mit.edu, xinhaoqu@huawei.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, samuel@sholland.org, cmuellner@linux.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022 at 05:06, Heiko Stuebner <heiko@sntech.de> wrote:
>
> Some current cpus based on T-Head cores implement memory-types
> way different than described in the svpbmt spec even going
> so far as using PTE bits marked as reserved.
>
> Add the T-Head vendor-id and necessary errata code to
> replace the affected instructions.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Philipp Tomsich <philipp.tomsich@vrull.eu>
