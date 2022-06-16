Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA82E54E252
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 15:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377230AbiFPNqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 09:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376858AbiFPNqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:46:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB19A37A8E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 06:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655387188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FmNUkOO/CPYlAiNCXkHb5y6oDWLQMyJAjm4NQJecMuc=;
        b=EjR/AdweSXh0nvnGu39ntP++djSW+9fkXmHeRHKS6oLt5c5QM9N8LqPP8KATwyVNx6LTfJ
        hU00OvO2OpjhSCfmXFMZeHBsQ45B4bskqwR5TARO649fbHfM1t+4o4MYN2Hk4vBgBeXKTu
        d5Zuj7fOYyzjB8dRFc5M9dWS7lszsio=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-h1PLAn-NMViEKO72XyHw_w-1; Thu, 16 Jun 2022 09:46:23 -0400
X-MC-Unique: h1PLAn-NMViEKO72XyHw_w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 728793C138A1;
        Thu, 16 Jun 2022 13:46:22 +0000 (UTC)
Received: from maya.cloud.tilaa.com (unknown [10.40.208.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 27A712026D2D;
        Thu, 16 Jun 2022 13:46:22 +0000 (UTC)
Date:   Thu, 16 Jun 2022 15:46:18 +0200
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Jie2x Zhou <jie2x.zhou@intel.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>, shuah@kernel.org,
        liuhangbin@gmail.com, fw@strlen.de,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philip Li <philip.li@intel.com>,
        kernel test robot <lkp@intel.com>,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] selftests: netfilter: correct PKTGEN_SCRIPT_PATHS in
 nft_concat_range.sh
Message-ID: <20220616154618.0eb6b283@elisabeth>
In-Reply-To: <Yqr9pQ9QsVaGjNW/@salvia>
References: <20220616074046.49349-1-jie2x.zhou@intel.com>
        <Yqr9pQ9QsVaGjNW/@salvia>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jie2x,

On Thu, 16 Jun 2022 11:53:41 +0200
Pablo Neira Ayuso <pablo@netfilter.org> wrote:

> Cc'ing netfilter-devel and Stefano Brivio.
> 
> On Thu, Jun 16, 2022 at 03:40:46PM +0800, Jie2x Zhou wrote:
> > Before change:
> > make -C netfilter
> >  TEST: performance
> >    net,port                                                      [SKIP]
> >    perf not supported
> >    port,net                                                      [SKIP]
> >    perf not supported
> >    net6,port                                                     [SKIP]
> >    perf not supported
> >    port,proto                                                    [SKIP]
> >    perf not supported
> >    net6,port,mac                                                 [SKIP]
> >    perf not supported
> >    net6,port,mac,proto                                           [SKIP]
> >    perf not supported
> >    net,mac                                                       [SKIP]
> >    perf not supported
> > 
> > After change:
> >    net,mac                                                       [ OK ]
> >      baseline (drop from netdev hook):               2061098pps
> >      baseline hash (non-ranged entries):             1606741pps
> >      baseline rbtree (match on first field only):    1191607pps
> >      set with  1000 full, ranged entries:            1639119pps
> > ok 8 selftests: netfilter: nft_concat_range.sh
> > 
> > Fixes: 611973c1e06f ("selftests: netfilter: Introduce tests for sets with range concatenation")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Jie2x Zhou <jie2x.zhou@intel.com>
> > ---
> >  tools/testing/selftests/netfilter/nft_concat_range.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/netfilter/nft_concat_range.sh b/tools/testing/selftests/netfilter/nft_concat_range.sh
> > index b35010cc7f6a..a6991877e50c 100755
> > --- a/tools/testing/selftests/netfilter/nft_concat_range.sh
> > +++ b/tools/testing/selftests/netfilter/nft_concat_range.sh
> > @@ -31,7 +31,7 @@ BUGS="flush_remove_add reload"
> >  
> >  # List of possible paths to pktgen script from kernel tree for performance tests
> >  PKTGEN_SCRIPT_PATHS="
> > -	../../../samples/pktgen/pktgen_bench_xmit_mode_netif_receive.sh
> > +	../../../../samples/pktgen/pktgen_bench_xmit_mode_netif_receive.sh

This came from the fact that I used, for testing, to copy the
directories 'samples' and 'selftests' to the root of a filesystem
on a virtual machine, instead of copying the full 'tools' directory.

It was a very arbitrary usage though, also given that 'selftests' is
typically biggest directory in 'tools', so there's no need to keep the
previous path.

Thanks for fixing this,

Reviewed-by: Stefano Brivio <sbrivio@redhat.com>

-- 
Stefano

