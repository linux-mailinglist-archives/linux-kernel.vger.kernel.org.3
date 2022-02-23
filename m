Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE224C192A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiBWQ6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243064AbiBWQ5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:57:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F38394F9DD
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 08:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645635443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9lYnlwo80ekeXGGRVop7tuYwutJe1OPkYrSCkXet1IY=;
        b=b0zVWW81StNSVD+Tj7iHkrC0lOsRpCC2RSTMlIS1fuc1UrpeXAGkp8iHz4gwvrWCcRqYYB
        krRcA17XmOavg69nYiBiRT5lL2s5AjtOr0DPN8EA6Gcb0pqJRHT0txpVg+VIb4x7hsQ76o
        SA4tsSOCWshA0NHZAnZsaUrWxpcmcsk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-dq1-TmmXOVeBpkO0u8THeg-1; Wed, 23 Feb 2022 11:57:21 -0500
X-MC-Unique: dq1-TmmXOVeBpkO0u8THeg-1
Received: by mail-lf1-f69.google.com with SMTP id v24-20020a056512349800b0043f1c29459bso3320575lfr.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 08:57:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9lYnlwo80ekeXGGRVop7tuYwutJe1OPkYrSCkXet1IY=;
        b=psFlp9zAnMnGn5iZCaBZgb/l+NNhcqkmObOluV2/JclDJMS7GXkRaVmIcJIN0ehnag
         Y/FLImLkDxgt4cYykoSSjOv83zr4T5rJhTO4k+950fxenY+CTk+Ut7iWE3P0sgkNFASE
         iuaYfucFrKWxmmcCBKpgYGVpMauXjqgLEdBkItBqow4GEyt6xnfRPkKnU9Jh9IB49ZcI
         ggUA6j7/LzN8+B7+UFkNT8xT0xFsJ7RL+mTIzRRZHtSFNmdTU9M0gtgJL/MNvusN2v4n
         88ft7fuAjeewdkOdVc5FsBZAp6zvbIv8ZJQ5c5boS4ktFZsp8HUb7/t8LSIA/yj4vkjh
         KPtw==
X-Gm-Message-State: AOAM532mnxbbVCxaXyMKXZgrKyDHvgNA595qPYG0PyhFhZ/YxrZLdx3J
        //Zpr8656sldAunvXd/fKkGCJkTAWb1nnjfdT5QZZTqBuYbdbnlNokMiXen8i2JFpZxSHr/b9DE
        yMBPC8Fq3mbs8N4EetWdgGpIB3DWsIuoGlLxZX1Q=
X-Received: by 2002:a05:6512:3e14:b0:429:6e79:ca87 with SMTP id i20-20020a0565123e1400b004296e79ca87mr373902lfv.163.1645635440062;
        Wed, 23 Feb 2022 08:57:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz8y+omW9xDDExHxhQDd6HLWNp9jDmHi7Vn79thFemSUK3HSORLo1ni7xvXLOo+Lt62XO3uuANFgjglrY2gMK4=
X-Received: by 2002:a05:6512:3e14:b0:429:6e79:ca87 with SMTP id
 i20-20020a0565123e1400b004296e79ca87mr373887lfv.163.1645635439848; Wed, 23
 Feb 2022 08:57:19 -0800 (PST)
MIME-Version: 1.0
References: <20220218212511.887059-1-atomlin@redhat.com> <20220218212511.887059-2-atomlin@redhat.com>
 <69fcaad3-e48c-11ca-ed50-7a18831e3e91@csgroup.eu> <CANfR36js06qG8HkQBPPz8bnYzcBRUtiZJAqhynt4XJcfcFXAQg@mail.gmail.com>
 <YhWK4woM1g2fAq72@bombadil.infradead.org>
In-Reply-To: <YhWK4woM1g2fAq72@bombadil.infradead.org>
From:   Aaron Tomlin <atomlin@redhat.com>
Date:   Wed, 23 Feb 2022 16:57:08 +0000
Message-ID: <CANfR36jtiq86FpONCFPOsh6x=eLnC9js+LewtUTSfZxoHoMb6w@mail.gmail.com>
Subject: Re: [PATCH v6 01/13] module: Move all into module/
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "cl@linux.com" <cl@linux.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "live-patching@vger.kernel.org" <live-patching@vger.kernel.org>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "ghalat@redhat.com" <ghalat@redhat.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-02-22 17:16 -0800, Luis Chamberlain wrote:
> How about:
>
> obj-$(CONFIG_MODULE_SIG_FORMAT) += module/module_signature.o
>
>   Luis

Hi Luis,

Please see v8 [1].

[1]: https://lore.kernel.org/all/20220222141303.1392190-1-atomlin@redhat.com/


Kind regards,

-- 
Aaron Tomlin

