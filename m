Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EE74D421D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 09:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240168AbiCJICU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 03:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiCJICP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 03:02:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF2C89D06C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 00:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646899273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BCFnueLhGq8x2QlstaEkS6sEylkHi4cQVPP6L/fjSHk=;
        b=iG3T31A97LXNRs7z95zCS2AJm8IKOHn5lU5uh1SPUN6HjPmnsT/jOUOL7i6c+uleUp4L8V
        1d244bujiQzR5G4huZ4y17VfhMrgiOZp/wUR3wKZoEo4fwqDM1Cw5F3UdII9th/GHmZj1v
        O5AAJliumko6BxPEFTW8iFtzckx4j4A=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-fWHcTAkHMbujBROWM6a7ZA-1; Thu, 10 Mar 2022 03:01:12 -0500
X-MC-Unique: fWHcTAkHMbujBROWM6a7ZA-1
Received: by mail-io1-f71.google.com with SMTP id f7-20020a056602088700b00645ebbe277cso3342874ioz.22
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 00:01:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BCFnueLhGq8x2QlstaEkS6sEylkHi4cQVPP6L/fjSHk=;
        b=pGczaVuaAuDVRWMVMZv0QgdOdn13pANomQu84FJzKmaqiZ7J+f0flMJh+E/gvvsgrh
         oVPhsqCiKOM2exC5nZjKaqUme/PHGcNKdHZsROmicpyc0kP9kgv8GkzcuisG6DV1MlO0
         Qp9pHwrWjqKud0h4gMLBCfaZ3Qu4F2SxILfDq8h6Y1wOu4Ebtz5jGRJXDf3EdjV9thiw
         S6wrviVrTYVvqXXBWoe+cCEVXL+BtkBTiI9pOh8iE24s51kB0vjMnoCFxOPMwtdGTiO1
         IPd6FI0b0Ghs6klkmOprAUA+0vz4cLZej0ovhM32ke1KZkGN3VcO5cfCbGzPpqI1rASv
         h/bg==
X-Gm-Message-State: AOAM532CXFICkSebXvHtS7jZl4LWgiaX9JrZMF2IDaC9lEd08YRFWRrd
        3TaaPp+nRKVKq4/u3KobutpJ0+CWMOX9ubL9S5kha2YCDdCEBwQPPkV1IS7TqjLlaMLe/FbHcDA
        PebixC7fn0ed59Zyo7lAGFhCtZFWP8zmF0Cx2tJZC
X-Received: by 2002:a02:c857:0:b0:317:bee6:48df with SMTP id r23-20020a02c857000000b00317bee648dfmr2939895jao.106.1646899270608;
        Thu, 10 Mar 2022 00:01:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwAPjUv6+sZhFhpeIhW9qpRYbDfVb/mdFFKsSK4LrT5o7vjAHtlILU2thgKW7CNpuk/oSfQGM9jdCpZs7JPX2w=
X-Received: by 2002:a02:c857:0:b0:317:bee6:48df with SMTP id
 r23-20020a02c857000000b00317bee648dfmr2939875jao.106.1646899270333; Thu, 10
 Mar 2022 00:01:10 -0800 (PST)
MIME-Version: 1.0
References: <202107070458.FO35EqwU-lkp@intel.com>
In-Reply-To: <202107070458.FO35EqwU-lkp@intel.com>
From:   =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date:   Thu, 10 Mar 2022 09:00:58 +0100
Message-ID: <CACT4ouey2QXf=PJThXG8adrLmCet4Ptu+VDDKBy2hOARqsghXQ@mail.gmail.com>
Subject: Re: drivers/net/ethernet/chelsio/cxgb4/sge.c:2571 cxgb4_ethofld_send_flowc()
 warn: missing error code 'ret'
To:     Dan Carpenter <dan.carpenter@oracle.com>, rajur@chelsio.com
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 7, 2021 at 9:37 AM Dan Carpenter <dan.carpenter@oracle.com> wro=
te:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   79160a603bdb51916226caf4a6616cc4e1c58a58
> commit: 52bfcdd87e83d9e69d22da5f26b1512ffc81deed net:CXGB4: fix leak if s=
k_buff is not used
> config: x86_64-randconfig-m001-20210706 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> New smatch warnings:
> drivers/net/ethernet/chelsio/cxgb4/sge.c:2571 cxgb4_ethofld_send_flowc() =
warn: missing error code 'ret'

This was already reported here:
https://lore.kernel.org/all/202107070458.FO35EqwU-lkp@intel.com/

CCing again Chelsio maintainer to see if they can tell whether an
error code is needed or not. My understanding is that it's not needed
in this case, but not 100% sure.

>
> vim +/ret +2571 drivers/net/ethernet/chelsio/cxgb4/sge.c
>
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2535  int cxgb4_ethofld_se=
nd_flowc(struct net_device *dev, u32 eotid, u32 tc)
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2536  {
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2537     struct port_info =
*pi =3D netdev2pinfo(dev);
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2538     struct adapter *a=
dap =3D netdev2adap(dev);
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2539     enum sge_eosw_sta=
te next_state;
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2540     struct sge_eosw_t=
xq *eosw_txq;
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2541     u32 len, len16, n=
params =3D 6;
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2542     struct fw_flowc_w=
r *flowc;
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2543     struct eotid_entr=
y *entry;
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2544     struct sge_ofld_r=
xq *rxq;
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2545     struct sk_buff *s=
kb;
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2546     int ret =3D 0;
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2547
> a422d5ff6defb1 Gustavo A. R. Silva 2020-06-19  2548     len =3D struct_si=
ze(flowc, mnemval, nparams);
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2549     len16 =3D DIV_ROU=
ND_UP(len, 16);
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2550
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2551     entry =3D cxgb4_l=
ookup_eotid(&adap->tids, eotid);
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2552     if (!entry)
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2553             return -E=
NOMEM;
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2554
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2555     eosw_txq =3D (str=
uct sge_eosw_txq *)entry->data;
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2556     if (!eosw_txq)
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2557             return -E=
NOMEM;
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2558
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2559     skb =3D alloc_skb=
(len, GFP_KERNEL);
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2560     if (!skb)
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2561             return -E=
NOMEM;
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2562
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2563     spin_lock_bh(&eos=
w_txq->lock);
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2564     if (tc !=3D FW_SC=
HED_CLS_NONE) {
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2565             if (eosw_=
txq->state !=3D CXGB4_EO_STATE_CLOSED)
> 52bfcdd87e83d9 =C3=8D=C3=B1igo Huguet        2021-05-05  2566            =
         goto out_free_skb;
>                                                                         ^=
^^^^^^^^^^^^^^^^
>
> Are these error paths?
>
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2567
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2568             next_stat=
e =3D CXGB4_EO_STATE_FLOWC_OPEN_SEND;
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2569     } else {
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2570             if (eosw_=
txq->state !=3D CXGB4_EO_STATE_ACTIVE)
> 52bfcdd87e83d9 =C3=8D=C3=B1igo Huguet        2021-05-05 @2571            =
         goto out_free_skb;
>
> Here too
>
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2572
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2573             next_stat=
e =3D CXGB4_EO_STATE_FLOWC_CLOSE_SEND;
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2574     }
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2575
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2576     flowc =3D __skb_p=
ut(skb, len);
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2577     memset(flowc, 0, =
len);
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2578
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2579     rxq =3D &adap->sg=
e.eohw_rxq[eosw_txq->hwqid];
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2580     flowc->flowid_len=
16 =3D cpu_to_be32(FW_WR_LEN16_V(len16) |
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2581                      =
                 FW_WR_FLOWID_V(eosw_txq->hwtid));
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2582     flowc->op_to_npar=
ams =3D cpu_to_be32(FW_WR_OP_V(FW_FLOWC_WR) |
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2583                      =
                  FW_FLOWC_WR_NPARAMS_V(nparams) |
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2584                      =
                  FW_WR_COMPL_V(1));
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2585     flowc->mnemval[0]=
.mnemonic =3D FW_FLOWC_MNEM_PFNVFN;
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2586     flowc->mnemval[0]=
.val =3D cpu_to_be32(FW_PFVF_CMD_PFN_V(adap->pf));
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2587     flowc->mnemval[1]=
.mnemonic =3D FW_FLOWC_MNEM_CH;
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2588     flowc->mnemval[1]=
.val =3D cpu_to_be32(pi->tx_chan);
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2589     flowc->mnemval[2]=
.mnemonic =3D FW_FLOWC_MNEM_PORT;
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2590     flowc->mnemval[2]=
.val =3D cpu_to_be32(pi->tx_chan);
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2591     flowc->mnemval[3]=
.mnemonic =3D FW_FLOWC_MNEM_IQID;
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2592     flowc->mnemval[3]=
.val =3D cpu_to_be32(rxq->rspq.abs_id);
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2593     flowc->mnemval[4]=
.mnemonic =3D FW_FLOWC_MNEM_SCHEDCLASS;
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2594     flowc->mnemval[4]=
.val =3D cpu_to_be32(tc);
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2595     flowc->mnemval[5]=
.mnemonic =3D FW_FLOWC_MNEM_EOSTATE;
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2596     flowc->mnemval[5]=
.val =3D cpu_to_be32(tc =3D=3D FW_SCHED_CLS_NONE ?
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2597                      =
                   FW_FLOWC_MNEM_EOSTATE_CLOSING :
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2598                      =
                   FW_FLOWC_MNEM_EOSTATE_ESTABLISHED);
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2599
> 69422a7e5d578a Rahul Lakkireddy    2020-04-30  2600     /* Free up any pe=
nding skbs to ensure there's room for
> 69422a7e5d578a Rahul Lakkireddy    2020-04-30  2601      * termination FL=
OWC.
> 69422a7e5d578a Rahul Lakkireddy    2020-04-30  2602      */
> 69422a7e5d578a Rahul Lakkireddy    2020-04-30  2603     if (tc =3D=3D FW_=
SCHED_CLS_NONE)
> 69422a7e5d578a Rahul Lakkireddy    2020-04-30  2604             eosw_txq_=
flush_pending_skbs(eosw_txq);
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2605
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2606     ret =3D eosw_txq_=
enqueue(eosw_txq, skb);
> 52bfcdd87e83d9 =C3=8D=C3=B1igo Huguet        2021-05-05  2607     if (ret=
)
> 52bfcdd87e83d9 =C3=8D=C3=B1igo Huguet        2021-05-05  2608            =
 goto out_free_skb;
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2609
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2610     eosw_txq->state =
=3D next_state;
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2611     eosw_txq->flowc_i=
dx =3D eosw_txq->pidx;
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2612     eosw_txq_advance(=
eosw_txq, 1);
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2613     ethofld_xmit(dev,=
 eosw_txq);
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2614
> 52bfcdd87e83d9 =C3=8D=C3=B1igo Huguet        2021-05-05  2615     spin_un=
lock_bh(&eosw_txq->lock);
> 52bfcdd87e83d9 =C3=8D=C3=B1igo Huguet        2021-05-05  2616     return =
0;
> 52bfcdd87e83d9 =C3=8D=C3=B1igo Huguet        2021-05-05  2617
> 52bfcdd87e83d9 =C3=8D=C3=B1igo Huguet        2021-05-05  2618  out_free_s=
kb:
> 52bfcdd87e83d9 =C3=8D=C3=B1igo Huguet        2021-05-05  2619     dev_con=
sume_skb_any(skb);
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2620     spin_unlock_bh(&e=
osw_txq->lock);
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2621     return ret;
> 0e395b3cb1fb82 Rahul Lakkireddy    2019-11-07  2622  }
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>


--=20
=C3=8D=C3=B1igo Huguet

