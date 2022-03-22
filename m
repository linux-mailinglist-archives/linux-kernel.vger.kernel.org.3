Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B784E3B3D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiCVIyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbiCVIyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:54:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D0E47DE0C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647939152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iyMWMxVWAGisdvJOYs+VVN86dCYSEjTUHb7tjwWEipE=;
        b=KwzOqbYqpC5pj8HXzAAS3YnGQcDdu8mmUq/DvQW3MADj5ZGeSopQhFp/IJEoBN1T3x3MJA
        27/zfCNwye4se7lzUT2SwhUwA3YSyniQ9F3Zq2VPzX22sdEWQfh9qpgxrQxdRob00cZSmX
        j0mYE25KrVGwbDvWGDYP9in8wcKKTtQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-CWzfubHnMNyvNcB5dRI3hg-1; Tue, 22 Mar 2022 04:52:30 -0400
X-MC-Unique: CWzfubHnMNyvNcB5dRI3hg-1
Received: by mail-wm1-f71.google.com with SMTP id t2-20020a7bc3c2000000b003528fe59cb9so544897wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=iyMWMxVWAGisdvJOYs+VVN86dCYSEjTUHb7tjwWEipE=;
        b=lLH1zd0qN5i9Gw4e6FYIo3RwaQujzCZhbBZxhBo/8D39mvifY7jFbrQu/VAZy3hkLT
         TQJDveWOiaSdVNchkf5p+D7s9rGFB5d0mgwe9eZffGbWgWVxH1uvzVYD3EbCcAH06WXh
         UlnakAF/gqYBAaFv2NTpNwNlzfakq4Xn/9BqaXMgxP/WsRD1xqhpnAOCyOaIFwoF7qCt
         X3KnHmWeDpyh2vD7rh8AD4u3lrP7iCZxsHijT425cQek9me5eY6PVhgb1OCQ4xkDIeYC
         zk+QbFV1TYfwKwRvs4Yj5bk60dRnUm5FFR4Z3et2v6QmlWDUPalcIbu9rAW7JByu78/f
         WhVQ==
X-Gm-Message-State: AOAM530cNifAtz2Gv0cq+fRND3Ny7ZQeEq3p08ZJOY5G416k4LveyQCE
        315p/GDXqXJqEyBAa6nCP8LGGuMHGM52N5TOEpPXdfAgyKznDgyj+DogQI3gQt+zMQuSdDxrjDF
        +caB3197Ag4vMw39UKhsPeVNZ
X-Received: by 2002:a05:6000:1e12:b0:203:ed33:8981 with SMTP id bj18-20020a0560001e1200b00203ed338981mr19039646wrb.525.1647939149583;
        Tue, 22 Mar 2022 01:52:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRdYdMvWp8eyiQYPO+MnNtfXHXtjHOuPL626IQMjpxjgJQt/FKMstA1whF/Tm2qk4+kGEtKA==
X-Received: by 2002:a05:6000:1e12:b0:203:ed33:8981 with SMTP id bj18-20020a0560001e1200b00203ed338981mr19039631wrb.525.1647939149357;
        Tue, 22 Mar 2022 01:52:29 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-232-135.dyn.eolo.it. [146.241.232.135])
        by smtp.gmail.com with ESMTPSA id 185-20020a1c19c2000000b0038a1d06e862sm1433369wmz.14.2022.03.22.01.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 01:52:28 -0700 (PDT)
Message-ID: <cb10f1946d38d551e408e3ab14998c0b434bf56a.camel@redhat.com>
Subject: Re: [PATCH] qed: remove an unneed NULL check on list iterator
From:   Paolo Abeni <pabeni@redhat.com>
To:     Xiaomeng Tong <xiam0nd.tong@gmail.com>, davem@davemloft.net,
        kuba@kernel.org
Cc:     aelior@marvell.com, manishc@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 22 Mar 2022 09:52:27 +0100
In-Reply-To: <20220319043606.23292-1-xiam0nd.tong@gmail.com>
References: <20220319043606.23292-1-xiam0nd.tong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, 2022-03-19 at 12:36 +0800, Xiaomeng Tong wrote:
> The define for_each_pci_dev(d) is:
>  while ((d = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, d)) != NULL)
> 
> Thus, the list iterator 'd' is always non-NULL so it doesn't need to
> be checked. So just remove the unnecessary NULL check. Also remove the
> unnecessary initializer because the list iterator is always initialized.
> 
> Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>

This looks like a net-next change, but net-next is now closed. please
repost 2 weeks, thanks!

Paolo

