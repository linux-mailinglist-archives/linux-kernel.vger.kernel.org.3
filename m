Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC125594EEC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 05:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbiHPDC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 23:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbiHPDB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 23:01:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 046AE2DF6B5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 16:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660606516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5zb/VZQAOIgiltymKi0EU4LqXYPn7kX2Sef7eElYFw8=;
        b=Ss82UcWPcDLgGGFhCg3gKeFJJieHjvHtBFX3G8/n8ZFc7HrYzElwOZ9t9Gtd8UohB0BK5Y
        xvt4jtFxm6nFGB+FhyEPi7scZEZzAKIGQjtXpjf+dVc/JUGceezwol6rBxLZrvCZLw11OF
        govagc2II2AkzINnD4dHAiCklE/goMI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-290-FhGpO4XyPNWnV-UWQoeZiw-1; Mon, 15 Aug 2022 19:35:14 -0400
X-MC-Unique: FhGpO4XyPNWnV-UWQoeZiw-1
Received: by mail-wm1-f69.google.com with SMTP id c17-20020a7bc011000000b003a2bfaf8d3dso4180611wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 16:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=5zb/VZQAOIgiltymKi0EU4LqXYPn7kX2Sef7eElYFw8=;
        b=XMe1+B/MlAxoVYTBJDTvPrvMNUK2npmiFN+Yaji1jZLbzLCQUp1ivsFUOlomb+S5cA
         mW/hk/wkflBrzfTBq0Qi23IBHGCxTmFOUKVC7FjcQxJQlqRLThlWXWo34lv3yme9vWcP
         wMhOVzHoQgDzc5KHVYAG5O35gHug9o4IfFz193L/vYCpudEn+tYOjEDrCUhIS6IgX/Vy
         sAbUhFeR3bQ6mNrejLM6jIgBe6RGH2ANw4YAjL/E452W2XC4SoN/DykMuF1kM51FhdnM
         s+N8ioVL7tDYl0BlbCz8V05pz4SIho3GGDl3Y5XgRmpZiwSfLZ8YL8R076ZD6ZOG35A7
         6TWg==
X-Gm-Message-State: ACgBeo0PewV7Xon7HNsOgC4z9CEUywMKiIOl1NX00ABMe3H+qZLwcDgq
        AdI1Mze9i5nR1/RaZ27UuefLbaKrlD/nF9GLIvGF1AFl7ifsQXxx5HhRyMwiY9AzcKcoEpC6hJv
        05tf1kh/RMDTwi7+tiulD7XM8
X-Received: by 2002:adf:e68c:0:b0:223:a74e:7e63 with SMTP id r12-20020adfe68c000000b00223a74e7e63mr9161860wrm.603.1660606513923;
        Mon, 15 Aug 2022 16:35:13 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7edmzM0cGxVsTi8/QYJs2FLXSn76zA+W0PpmBcUpfrSpvST9v2wXq+kEHGhFwDZ7zGXJdYvw==
X-Received: by 2002:adf:e68c:0:b0:223:a74e:7e63 with SMTP id r12-20020adfe68c000000b00223a74e7e63mr9161853wrm.603.1660606513724;
        Mon, 15 Aug 2022 16:35:13 -0700 (PDT)
Received: from redhat.com ([2.55.43.215])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c501200b003a545fe9db4sm11056782wmr.23.2022.08.15.16.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 16:35:12 -0700 (PDT)
Date:   Mon, 15 Aug 2022 19:35:07 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 0/5] virtio: drop sizing vqs during init
Message-ID: <20220815193438-mutt-send-email-mst@kernel.org>
References: <20220815215938.154999-1-mst@redhat.com>
 <CAHk-=wj=Ju_jhbww7WmpgmHHebMSdd1U5WBjh925yLB_F1j9Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj=Ju_jhbww7WmpgmHHebMSdd1U5WBjh925yLB_F1j9Ng@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 03:24:28PM -0700, Linus Torvalds wrote:
> On Mon, Aug 15, 2022 at 3:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > But the benefit is unclear in any case, so let's revert for now.
> 
> Should I take this patch series directly, or will you be sending a
> pull request (preferred)?
> 
>              Linus

I'll be sending a pull request, just not today - I try not to do
this at strange hours of night.

-- 
MST

