Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F314E27FC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348066AbiCUNpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348059AbiCUNpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:45:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6C151A835
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 06:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647870246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pnAmXlnXLTHp0iSG/dGGWw30Ukf/zjdTAa7UkhvknLc=;
        b=aVBRxxITTGGbp+oJTOjne1qhiwC0UxeCqJFIXMV9AW2Ze+u2JiTCJlz9V0bfC0csW1sFR8
        20Fr4BmfHOUO6cfDy5CEbu443VFK35YnJrqey6ESTtwEd8iUFURt8yq55DespmZiP462hV
        gTomVAdlJh47ebTeB7jVrjNL2EO9wXY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-dL8skpVHMiCYMldbCl7Ftw-1; Mon, 21 Mar 2022 09:44:05 -0400
X-MC-Unique: dL8skpVHMiCYMldbCl7Ftw-1
Received: by mail-qt1-f197.google.com with SMTP id x9-20020ac81209000000b002e0659131baso2878685qti.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 06:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pnAmXlnXLTHp0iSG/dGGWw30Ukf/zjdTAa7UkhvknLc=;
        b=j5h0FAxDNNDt8pw0h4ZjgfV/fDNWCc87Yrpw0+mlF32sQlkXwo+o7q+PJkJnwtif7n
         hfMnlPsL9gM0cZMQQzhCvA9ytHk9pcThwfD5ZTN1Ony+avq4wJLmxueU3ClwnXvJSbtC
         rk2agxotMfbZRqV1XYZL3fhlAaV1JKX0UsV36/wcC5AViPAzzY6bAHdAnsqYu/Yi2Sfo
         4XjXGvkFCu7n7ueeXvhXcy+hWVCGLW59VuP9vnSzAkvd5LV97oRFYiVRfKz/LbjFFd1A
         XJaNAZFOORDRY5w13P6g+r79k2750DtuKXVHRBRtGRFPjR2/0HL8RuzCFwsoeXBTKIOh
         cr1g==
X-Gm-Message-State: AOAM532tL5dh0AEiiAoiVFD+R7dCGHnwLroK87nQdZBFK2euFenWAFUN
        qZ8a6xwI+LB2kO3KcjrwyG9hVH4sOvvhlxu33ijMRqqbaFzBkKJh7OaJzXBc/PRFPT7b6yBtxKG
        SUzd7V3HS/E1JaDqrjqzXiUdC
X-Received: by 2002:a05:622a:1052:b0:2e1:fe6b:377d with SMTP id f18-20020a05622a105200b002e1fe6b377dmr13196876qte.229.1647870245102;
        Mon, 21 Mar 2022 06:44:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCbc10lLPdAfISHXGX6/OQIVT02pfqbNlUvvEv/dlqMfFKGpEgfAK1zb2wblj6cYu2rsDSkg==
X-Received: by 2002:a05:622a:1052:b0:2e1:fe6b:377d with SMTP id f18-20020a05622a105200b002e1fe6b377dmr13196847qte.229.1647870244882;
        Mon, 21 Mar 2022 06:44:04 -0700 (PDT)
Received: from xps13 (c-98-239-145-235.hsd1.wv.comcast.net. [98.239.145.235])
        by smtp.gmail.com with ESMTPSA id v3-20020a05622a188300b002e1cbca8ea4sm12420986qtc.59.2022.03.21.06.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 06:44:04 -0700 (PDT)
Date:   Mon, 21 Mar 2022 09:44:03 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [RFT] ufs: qcom: drop custom Android boot parameters
Message-ID: <YjiBIx+QY2EtFBtO@xps13>
References: <20220320110616.18355-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220320110616.18355-1-krzk@kernel.org>
User-Agent: Mutt/2.0.7 (2021-05-04)
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 20, 2022 at 12:06:16PM +0100, Krzysztof Kozlowski wrote:
> The QCOM UFS driver requires an androidboot.bootdevice command line
> argument matching the UFS device name.  If the name is different, it
> refuses to probe.  Thise androidboot.bootdevice is provided by
> stock/vendor (from an Android-based device) bootloader.
> 
> This does not make sense from Linux point of view.  Driver should be
> able to boot regardless of bootloader.  Driver should not depend on some
> Android custom environment data.
> 
> Cc: Luca Weiss <luca.weiss@fairphone.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

I encountered that same code a few months ago and thought then that
this code doesn't belong here.

Reviewed-by: Brian Masney <bmasney@redhat.com>

