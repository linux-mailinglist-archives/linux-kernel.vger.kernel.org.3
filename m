Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DB458D05D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 01:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238131AbiHHXHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 19:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbiHHXHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 19:07:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B778193FF
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 16:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660000041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VTykkjMreZGlPtiHtJZVriJJcrzikHVxhAuXCB1qSxU=;
        b=GJPrdjID4RrT99pF1/+MGkpwb9teDdOVr2vJK9n2EqESVvWK65Kv/xATL3Xkn6cmCUusPq
        P/frmVPGzdHSb7B8qhQqnX2vkQesmLrfpZl9+cwLpGgYowq+C77LdGWYcE3zjcigeRZwck
        amwYQ8MWvwheQxb7sHNzEJeKuWe4F78=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-21-fTT0zMA7MKaD9tBZZgcQ4g-1; Mon, 08 Aug 2022 19:07:20 -0400
X-MC-Unique: fTT0zMA7MKaD9tBZZgcQ4g-1
Received: by mail-qk1-f198.google.com with SMTP id y17-20020a05620a25d100b006b66293d75aso8982548qko.17
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 16:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc;
        bh=VTykkjMreZGlPtiHtJZVriJJcrzikHVxhAuXCB1qSxU=;
        b=RLAy/GNlglrb+3bECQibDnPZbyp4kby0lXVg3tYZnkbNKAB/tuA68KP7tW2B9q8Q59
         4l02NzIr87nz3e7N3Yj7RR3wZ2LfagnkkwOxEipepTPFaSgR9oNonssn4T7bY4Z70VHI
         Hyc0d2QqlYh/Ff7sqcyRNv0RSdihQHFABNr5ObHPB15FGK8oA+eCiencG4eBuGczKWwU
         I75uwk35D/J1zUBZpLoQ5HoPbNcXmpNKLYIaGadCmqDPNB9ITcdXutWW2ksxJOb3PCXE
         BUTGjAmRccsBjRc+XGmptGWngsdjUuum0BuN3lI9jgvc5WOOn9stbYEwcnD842r/70Ab
         Q2Jg==
X-Gm-Message-State: ACgBeo3xcSkdA0V3mx9MlNDGapDHFPXXJAp2PasCb0vuk/yvFXob8DMA
        5QGMuVMSVKWnpinBhF/XnBeP3z7+nG0Ax9cz7N3rCCuY0nhMmTskZV6AsGFnSNUZ0HeGuvwmVcF
        z5QObktYyavuarVde1uNoZMXQ
X-Received: by 2002:ac8:5bd3:0:b0:343:3d7:b35e with SMTP id b19-20020ac85bd3000000b0034303d7b35emr2847924qtb.684.1660000039785;
        Mon, 08 Aug 2022 16:07:19 -0700 (PDT)
X-Google-Smtp-Source: AA6agR46tDYlnYw3pgmddX2HjPE1Rbd1ysZz8fH6jnfgN+WWv+32bU9uk9MafWASDaWLB6SisWPYGw==
X-Received: by 2002:ac8:5bd3:0:b0:343:3d7:b35e with SMTP id b19-20020ac85bd3000000b0034303d7b35emr2847909qtb.684.1660000039598;
        Mon, 08 Aug 2022 16:07:19 -0700 (PDT)
Received: from [192.168.8.138] (pool-100-0-245-4.bstnma.fios.verizon.net. [100.0.245.4])
        by smtp.gmail.com with ESMTPSA id bm32-20020a05620a19a000b006b8e63dfffbsm10296141qkb.58.2022.08.08.16.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 16:07:18 -0700 (PDT)
Message-ID: <cab2385388606f3292e55d962a8ddedac0540f2c.camel@redhat.com>
Subject: Re: [RESEND RFC 06/18] drm/display/dp_mst: Add some missing kdocs
 for atomic MST structs
From:   Lyude Paul <lyude@redhat.com>
To:     "Lin, Wayne" <Wayne.Lin@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc:     Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Date:   Mon, 08 Aug 2022 19:07:17 -0400
In-Reply-To: <CO6PR12MB548907FE2E64F8D8CC5D5227FCAD9@CO6PR12MB5489.namprd12.prod.outlook.com>
References: <20220607192933.1333228-1-lyude@redhat.com>
         <20220607192933.1333228-7-lyude@redhat.com>
         <CO6PR12MB548907FE2E64F8D8CC5D5227FCAD9@CO6PR12MB5489.namprd12.prod.outlook.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also JFYI - I did see this comment but didn't address it in my respin, but
only because I figured this might be better for a followup patch considering
how much work is already in here

On Wed, 2022-06-15 at 04:43 +0000, Lin, Wayne wrote:
> I would prefer not using the term "available" which is a bit conflicting with
> the idea in the reply of ENUM_PATH_RESOURCES - full PBN & available PBN.
> Maybe better to change to use "full_slots"?
> 
> Not yet finish all the patches. Will try to go through all the patches recently : )

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

