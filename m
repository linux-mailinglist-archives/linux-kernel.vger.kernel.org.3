Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836B25929EA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 08:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241128AbiHOG4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 02:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241151AbiHOGzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 02:55:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D47EBF585
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 23:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660546542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s27ZkPXAKFlLDtakqNA0q70iNz46u3nf8VUdJxUpsDw=;
        b=VhjS4CpeN6WyYaPRcHJN0mp8iX1yicytUmXfMQSFGqL4jIkMihYafsxh9G6tHdBS8AEdL6
        jLxW2fczbLbMKa0uPbAjZAMrnwQoK33biBRFsxkC8WAZ4lZE4mOg/8nF/V6dcbnRGSQvs3
        YuQHFchaStUntbocT/Su4UA5CLsNk7w=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-623-xVT9LJSFPv6z_FqcyxtiwA-1; Mon, 15 Aug 2022 02:55:39 -0400
X-MC-Unique: xVT9LJSFPv6z_FqcyxtiwA-1
Received: by mail-pj1-f71.google.com with SMTP id a17-20020a17090abe1100b001f320df2e97so7853800pjs.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 23:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=s27ZkPXAKFlLDtakqNA0q70iNz46u3nf8VUdJxUpsDw=;
        b=KB23GBdMvvlyujvFguZp8NPGV9CzVLx/9QMwFksvlGdiwH4iGzXiFBzMXMH3bQ0aMl
         Vb8jygepm7FmtxeMw2IKgZ2veE++jSXSZXi5d3F5mVBitqMRMiW2oYeMGUjZJ9mZ4+jo
         nwtIFQGBO9YgY34VO9ymSaPKsFR3QOTqQFh2VbX6qppE3ZBv5mOZbmzfwsCwLsRV8bs4
         VEZey9EdvxVLo5k55l2iDeRTJ+PuJYSW1Pes27yOS5fyQ+cUW/tjhrT3kpTIR2i4jeWX
         zwJzI8ugT52iE2D0TO5T/mhldKeejnUraJB/6OTJwFn+nm5U66rEClYMu1l0gHMVcoGA
         GJAQ==
X-Gm-Message-State: ACgBeo1bFW6pZZ4cjkJH2iMSbrf6xyOK+8C398CwrnbqqCRg671bk0eM
        0kLHjvTPOHWMpLk9FiULwLivZFymVE/4b6P8MTuRUo6bvdl1lTMndUI+BumhRpKNWe/zuSkF7X9
        FbbOR3b9gEdwKRUI4OPxVeRT4
X-Received: by 2002:a17:90a:5888:b0:1f5:f1d2:54bb with SMTP id j8-20020a17090a588800b001f5f1d254bbmr25854879pji.178.1660546538536;
        Sun, 14 Aug 2022 23:55:38 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5gSneUL2Qdvf4jY+Km6lnQKEAMNgjtedDGxytTE89P2b0LLUeE3NqKVwS7DQzMiYmV23B6Fg==
X-Received: by 2002:a17:90a:5888:b0:1f5:f1d2:54bb with SMTP id j8-20020a17090a588800b001f5f1d254bbmr25854861pji.178.1660546538288;
        Sun, 14 Aug 2022 23:55:38 -0700 (PDT)
Received: from localhost ([240e:3a1:2ea:acc0:8cff:e01c:2dbf:2ae8])
        by smtp.gmail.com with ESMTPSA id l20-20020a17090b079400b001f89383d587sm4015601pjz.56.2022.08.14.23.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 23:55:37 -0700 (PDT)
Date:   Mon, 15 Aug 2022 14:53:25 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     kexec@lists.infradead.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, nayna@linux.ibm.com,
        nasastry@in.ibm.com, mpe@ellerman.id.au
Subject: Re: [PATCH v7 0/6] tpm: Preserve TPM measurement log across kexec
 (ppc64)
Message-ID: <20220815065325.h3t3igr6nogf7h23@Rk>
References: <20220812164305.2056641-1-stefanb@linux.ibm.com>
 <20220815064813.77g6icbkygrbmapa@Rk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220815064813.77g6icbkygrbmapa@Rk>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 02:48:13PM +0800, Coiby Xu wrote:
>I can confirm this patch set fixes an issue that guest kdump kernel
>crashes on POWER9 host by applying it to 5.19.1 (there is a conflict
>when applying this patch set to latest kernel i.e. 6.0.0-rc1).

FYI, here's the error of applying it to 6.0.0-rc1,

[root@localhost linux]# git am ../v7_tpm_log.mbox 
Applying: of: check previous kernel's ima-kexec-buffer against memory bounds
error: patch failed: drivers/of/kexec.c:126
error: drivers/of/kexec.c: patch does not apply
Patch failed at 0001 of: check previous kernel's ima-kexec-buffer against memory bounds
hint: Use 'git am --show-current-patch=diff' to see the failed patch

-- 
Best regards,
Coiby

