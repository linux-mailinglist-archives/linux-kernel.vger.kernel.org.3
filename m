Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475A7537705
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 10:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbiE3Ikq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 04:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbiE3Iko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 04:40:44 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77400643F
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 01:40:43 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id h62-20020a1c2141000000b0039aa4d054e2so1875652wmh.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 01:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=92MW+NUwSN2oHUR6zJpXV5eSZr3pkhKmrXl2e1uhV5U=;
        b=BgXPzHwaQpp30R/EHi1k98GTOEVhuszHcWCSuQ7/P+kX7QoMBFe8Qwz4t8oqX0YqcA
         uGdIltLgimUNCykZAKUWfS3QNvvRopzTnh001Kp2LoQMOhNNUgqkPNee6JP88JLTb4yB
         fRRgMsgFhibgmpOgSdFVgrTLRI/nUKo/0nTwhK/AAnXsAr4FZnbMZ9cxmdNGqtRbbyqb
         ugdLyD2rllvhWcwoCP+6KcxaJlA2P99B44xvV1q7vcda6emoP03mE9W7fPyV5LroSd2J
         BjKqLoLZYxg1sN5k1pd9RsrXwFYWji2/hKPMvW+6TOsLfS/JJY0XchY1jn84IUYWj9Ff
         yvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=92MW+NUwSN2oHUR6zJpXV5eSZr3pkhKmrXl2e1uhV5U=;
        b=qAQA5XvBrUF08PYs+i10XCY40Cj7rSTjnEXXH1ZPTquGUC730Dd9i9/eS2QfSvDPBa
         XBoCt2sRkQmvWMm3zVUltPOo+xQMomanpi1YsjDHarRSDhhZh6ujg5tDBFGjrWZdsz6N
         PnY1btTQqtdyQVer1i0+DdbYE8gIq6t4hH4FNCt9+q4d/injDR8Q4b1fjNMeUhgImKuB
         vE3J9c2es8oOOEAeV7CGMpluS7CWW6LgAanzsHCRpwIpbxLz2OC5iGZsEhBRP9P2usBT
         Z+f1woFSeiB6+9olpqlgp/VrX6Pu6F+Ugezr0ItEg11FCn8uQID98OAEJenaN3dOIjYb
         kRTQ==
X-Gm-Message-State: AOAM533uxIGh1TM+RSICHKqtq6G79GZMaq308789zzmrLxVdjL4pUbuM
        8kLlGPbunvVxD4G6XWHThTD5iJGKrdOkrJgw
X-Google-Smtp-Source: ABdhPJyNAKWz3jE+nMYF75b4UOk9YAlnCK9mS0OHEiJn6rlhqVWkUx7F+VQ9FLtWhHmulqqfzRI/Mg==
X-Received: by 2002:a1c:4443:0:b0:397:38a7:30 with SMTP id r64-20020a1c4443000000b0039738a70030mr17581027wma.14.1653900041940;
        Mon, 30 May 2022 01:40:41 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id a7-20020a5d5087000000b0020e608186a5sm8189848wrt.48.2022.05.30.01.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 01:40:41 -0700 (PDT)
Date:   Mon, 30 May 2022 09:40:39 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     richard clark <richard.xnu.clark@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        s32@nxp.com, leoyang.li@nxp.com, catalin-dan.udma@nxp.com,
        bogdan.hamciuc@nxp.com, bogdan.folea@nxp.com,
        ciprianmarian.costea@nxp.com, radu-nicolae.pirea@nxp.com,
        ghennadi.procopciuc@nxp.com
Subject: Re: Question about SPIs' interrupt trigger type restrictions
Message-ID: <20220530084039.7rjjbm4gkplg5747@maple.lan>
References: <CAJNi4rNwPQf747UM_hiYYwL=HDxg8QnPpfFPv1PfrtN9ZP1y1g@mail.gmail.com>
 <35f95ba3-8a7b-7918-0f9d-e14274a5ffe9@arm.com>
 <CAJNi4rMbBbLP2Tsv-wnnJKt4Y0moOE5-sNaZN1fCty908pwAKw@mail.gmail.com>
 <87ee0gn5rq.wl-maz@kernel.org>
 <CAJNi4rOHYqL8jN5Ju3ndANc-5Te4WEc-z5YGxCN-2ZtN8vf1cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJNi4rOHYqL8jN5Ju3ndANc-5Te4WEc-z5YGxCN-2ZtN8vf1cQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 08:09:32PM +0800, richard clark wrote:
> CC'ing some nxp guys for the S32G274A SOC...
> 
> On Thu, May 26, 2022 at 2:54 PM Marc Zyngier <maz@kernel.org> wrote:
> > richard clark <richard.xnu.clark@gmail.com> wrote:
> > > On Thu, May 26, 2022 at 3:14 AM Robin Murphy <robin.murphy@arm.com> wrote:
> > > > On 2022-05-25 11:01, richard clark wrote:
> > From the GIC500 r1p1 TRM, page 2-8:
> >
> > <quote>
> > SPIs are generated either by wire inputs or by writes to the AXI4
> > slave programming interface.  The GIC-500 can support up to 960 SPIs
> > corresponding to the external spi[991:32] signal. The number of SPIs
> > available depends on the implemented configuration. The permitted
> > values are 32-960, in steps of 32. The first SPI has an ID number of
> > 32. You can configure whether each SPI is triggered on a rising edge
> > or is active-HIGH level-sensitive.
> > </quote>
> >
> > So I have no idea what you are talking about, but you definitely have
> > the wrong end of the stick. Both the architecture and the
> > implementations are aligned with what the GIC drivers do.
> 
> What I am talking about is - The SPI is triggered on a rising edge
> only, while the falling edge is not as the document says. But I've
> observed the falling edge does trigger the SPI interrupt on my
> platform (the SOC is NXP S32G274A, an external wakeup signal with high
> to low transition to wake up the SOC - 'Wakeup/Interrupt Rising-Edge
> Event Enable Register (WIREER)' and 'Wakeup/Interrupt Falling-Edge
> Event Enable Register (WIFEER)', WIFEER set 1 and WIREER  set 0
> works).
> 
> I don't know why the GIC has such a behavior and what the subtle
> rationale is behind this, so just mark this as a record...

Are you really describing the GIC behaviour here? It sounds like you are
describing the behaviour of the Wakeup Unit.

The SPI that goes to the GIC is the *output* of the WKPU. However the
registers you mention above all control edge detection at the input to
the WKPU. If so, the kernel would need an WKPU irqchip driver in order
to manage the trigger mode registers above (and to clear them).


Daniel.


PS I can't find any sign of a WKPU driver in the mainline kernel and
   AFAICT this would make wake up sources unusable. What kernel have
   you been running your experiments on?
