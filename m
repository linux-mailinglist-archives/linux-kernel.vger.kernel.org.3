Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773D5528935
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245464AbiEPPxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbiEPPxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:53:32 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E439CE09
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:53:29 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id b18so26563804lfv.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EbahZ8s//MhvZATU5N16vyp5s7VaSnO5nIae4gl0gk0=;
        b=ZP4hri7brP1qH58wG7aKs9+/EslXVGswsHOgXd3Rly2rJt/+O76tPfhxL7OwmpIwKG
         6wxQXWKip2N/EbSsEuz8ZCxYCRYXfvipes/E3nYbQNtQdToMtCFZTl+dbTP2aNk37M9M
         gkn5YyTaHT7izE374+uIt7ybmQc99y30uNZ+augubzOaQ7Hme6ZJ8C9uj5dwxNr6yOrv
         itifkK9fRB+fkvL/kQ47zp+yg5CvyBsRLWTxZrPn/3NM3P10rrFzAU7DsLksyzRXTWpQ
         Ze+X+dmzPJiFyVH2T14K1fYnM7qMHdH0cQuOcMtHoY6Rv+G6cu0e6ghaQJ5PT6NS9ayK
         5C/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EbahZ8s//MhvZATU5N16vyp5s7VaSnO5nIae4gl0gk0=;
        b=1Ye6csIU6BL+F9V+ioPYYrCHkEFpNxHFAKS58CvIixARaYOszix3bFWPDlsneMyzzB
         ndRr9S7vL186TzMerDEt4s6t8FZ6OU2/mJAykPzar9yY1uHCJFHx8vqHDhO1wljU0Afw
         7rediUVBqUrKEQ9wdPJ1v+4/vLHLvEO1wgXSRmFcpgceUbneay18RwBe7tumqWSJGBnx
         s9QUe3JHfxTjzCBdT149C8r1+ueNytQfmuDEvagKkhEcEuJdVngdrxv0eT9zQ7EO+/BJ
         s3lU+Eu+7Kt9x6zZLgq1SIICNEkQ+IR+ayuaszrLfKZmeNN3u9O2jP/lsE85/YXL1+E4
         LEKQ==
X-Gm-Message-State: AOAM532F9iirleVcYO6o/fe0pDDK1JvZwHZPrQumf83rvYh9jXDR9to3
        ouyxRzYV/LoEIBpACh4UzdDoVSGF1VhpQWv/WdCCyA==
X-Google-Smtp-Source: ABdhPJxei5pzg/U2wRl0hGmPsf3kjsYStTXCMlzuL0wRt4xbfEY2ZaFF4tA7VhL8sWDgD3KFEkxl9RE8sbSWb/FOMc8=
X-Received: by 2002:a05:6512:234c:b0:473:c3ba:2cf1 with SMTP id
 p12-20020a056512234c00b00473c3ba2cf1mr13694486lfu.402.1652716407646; Mon, 16
 May 2022 08:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220516154512.259759-1-john.allen@amd.com>
In-Reply-To: <20220516154512.259759-1-john.allen@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Mon, 16 May 2022 08:53:16 -0700
Message-ID: <CAMkAt6oUxUFtNS4W0bzu13oWMdfnzfNrphH3OqwAkmxJcXhOqw@mail.gmail.com>
Subject: Re: [PATCH v2] crypto: ccp - Use kzalloc for sev ioctl interfaces to
 prevent kernel memory leak
To:     John Allen <john.allen@amd.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Ashish Kalra <Ashish.Kalra@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Nguyen <theflow@google.com>,
        David Rientjes <rientjes@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 8:46 AM John Allen <john.allen@amd.com> wrote:
>
> For some sev ioctl interfaces, input may be passed that is less than or
> equal to SEV_FW_BLOB_MAX_SIZE, but larger than the data that PSP
> firmware returns. In this case, kmalloc will allocate memory that is the
> size of the input rather than the size of the data. Since PSP firmware
> doesn't fully overwrite the buffer, the sev ioctl interfaces with the
> issue may return uninitialized slab memory.
>
> Currently, all of the ioctl interfaces in the ccp driver are safe, but
> to prevent future problems, change all ioctl interfaces that allocate
> memory with kmalloc to use kzalloc.
>
> Fixes: e799035609e15 ("crypto: ccp: Implement SEV_PEK_CSR ioctl command")
> Fixes: 76a2b524a4b1d ("crypto: ccp: Implement SEV_PDH_CERT_EXPORT ioctl command")
> Fixes: d6112ea0cb344 ("crypto: ccp - introduce SEV_GET_ID2 command")
> Cc: stable@vger.kernel.org
> Reported-by: Andy Nguyen <theflow@google.com>
> Suggested-by: David Rientjes <rientjes@google.com>
> Suggested-by: Peter Gonda <pgonda@google.com>
> Signed-off-by: John Allen <john.allen@amd.com>
> ---
> v2:
>   - Add fixes tags and CC stable@vger.kernel.org
> ---


static int sev_ioctl_do_platform_status(struct sev_issue_cmd *argp)
{
struct sev_user_data_status data;
int ret;

ret = __sev_do_cmd_locked(SEV_CMD_PLATFORM_STATUS, &data, &argp->error);
if (ret)
return ret;

if (copy_to_user((void __user *)argp->data, &data, sizeof(data)))
ret = -EFAULT;

return ret;
}

Would it be safer to memset @data here to all zeros too?
