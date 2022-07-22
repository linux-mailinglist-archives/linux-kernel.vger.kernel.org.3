Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37DE57DB4C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 09:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbiGVHbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 03:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbiGVHbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:31:15 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759911409B;
        Fri, 22 Jul 2022 00:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658475074; x=1690011074;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HsylFilObSVKooSBAU+7hgDatxMDgzhwJa6xAwvtLKg=;
  b=ARTQzNCxKE37zlKffJCULVTYrl+s+4lV+IGzu0eHsNvEkQhmWAmwATCc
   5wacJZO3LcOF+sU9ZXVmMdjZEqNoMFFLIet1+wiY3Fa5NSwlGNcNvBo/D
   b8ZiJFucE5oz6lqwP9EQZokbLPxzxGO7qSYI0wDVUKGVyU+szhbLkvivj
   tx51Kuz5FuijntTniRjlAjklvJj4D6uGAg16G7agh8h4ubazk7s9OS0J0
   UnlApfX7VLgPfRJxwjabWadKyghLyqdSuRcRQGur6opGLnEJT+yIsRi02
   os98wqF/e95k44RuL3IF1PAlKQqKd+RTPhu/Lmap5xBvF+pJ5sA6CaiYL
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,185,1654531200"; 
   d="scan'208";a="207266965"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2022 15:31:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lt84ZgpZVAKKGctcmGvMuZ3vpQTuDXCvYUvq3zwd1QY3cSvAkgXafr9HI2F1pVGQPwd8UYt0FHvFJJzJ9cba45blX5VPkhrfTNaZaqIoZ9DH4O7JeKSvmWW850gINv0BYD3B4S/indatsSnteojWoIoKSI5IOmi3wvTDAOI/NO2nx4R/H577bIvyAuz2O0D0pdJSyg8JzwBlwkHQlIdsL/4ZsRJ7g/kwbW25iQ6P3y/BR+toJuQM7yAUgViqgsEycEwjUJ70JosMnHWdImALRSKifsbUnqHxEut4aUcNtMZ9/a5yRh6XX4Gxu8kiSjZg5Se6e+yWuvVvqa3Gd5wQ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LPr24z2ra+iswFZEZWYI1FPD3+sCIhJ2nfcTyKqQ30=;
 b=YmasF15UXoNhTMlwN0OiHhNB2trDiWgeiPLzyEHZQDAAC82HcWSYEWH/DGBnq6VzjPB6V6kvfeeuTVhtZyNHTLFGd1U2Vku+eLJ/tWvK93fpU7FRa2JZ9fzzDV530wCGKUq90T7BqUNz2Ajz47jaay6hyzxZ3Zrqhn5ughgyVBxcNyeA6YrJndTXdxcEKxvMZOoOJWmzpuU4kIyLcovfSgWnFs0htW/CyB1yYUtDkj2LEUh2TQX0fWazsHAp3M5W2kMwIRvHueeGJyl+XD/80A0F/AVHuW4fxT0o066cP+iBxOVBqQUnJxNOhSbR+TuoT8lma40t922R3wsEGLtsjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LPr24z2ra+iswFZEZWYI1FPD3+sCIhJ2nfcTyKqQ30=;
 b=Q9zyyXO9+OvVOtDtmvMk5/+FjFcQvWFXfwxfKl2aC/G8HSOmgSjmDValWOvJJTh+MAJBaOtZI5U0IYeObvcG09VY30EdTIGOCD6QULE3i/Df9GguHyMKf4aRwwuTNG9oNJFMTGF+RkTPYtr8nbdttw18xosXfqoOwSnIhZsZyXU=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SN2PR04MB2157.namprd04.prod.outlook.com (2603:10b6:804:e::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.14; Fri, 22 Jul 2022 07:31:07 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31%8]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 07:31:07 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Can Guo <quic_cang@quicinc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "quic_ziqichen@quicinc.com" <quic_ziqichen@quicinc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>
CC:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
Thread-Topic: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
Thread-Index: AQHYmz2OvInxSH8TlUq8qOHvad4nHq2IiDZA
Date:   Fri, 22 Jul 2022 07:31:06 +0000
Message-ID: <DM6PR04MB65750EE12401C4F69B352E5CFC909@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <1658214120-22772-1-git-send-email-quic_cang@quicinc.com>
 <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
In-Reply-To: <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf981295-0ce8-4406-6528-08da6bb42413
x-ms-traffictypediagnostic: SN2PR04MB2157:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y2/24OFawYx+jouSf7tL8bcYEtzn0GMNbBzWbdJ0+nWy4KHFiMH5i4fgL9ux+iPA3vvD/XnN8A38Mc4JMaLhcdwgTb0yNJUlkNMQ+s2gPP0NySIKGjZyuji5b3wg5+4yai6ZI37S49brLOmIcZoZ/I9phi7vLXOoOPTV8Csf6vsGKX7IXb1ji2eHG5jQOqD9XVKTVuj0JsN4S49CMIDvHgBtSY/VXPdXcxaPxCHMl6ZNBC8FQ3oAtZlAhXH3tNhmPPQx1zs509ObIqiuhwFjNSCJZ8q71x7DPXNk0aQEt6rNdcrgtuDy+e9VdQjlPy3842TAOhU6Y+tH3WXRYHzlgLaJziUSnN/WZrJFrX6Kbn1ql6ZfzKwidO22rwMjnmPFKipUsTCG7y0AsVW9ov2DV7z71B/jyXxaGlTRFzWcsCaa2rK7P4Cma3m6kAuAV+zBX3eOC9A7mAJX+HZkg0Tpi4K/e6b7QH8NVCin+pROeaRdV85oKAiOoXDCPH2RZ5nzq7Lvt8ozbJGPQvhV4niJgmOIvhS4fjabL2Ahxp9cn49T7RllNOjHv/vlmhJ6XH2hXKjpet9lUfpmZXl9nkG68yxw4yZexGSh4/arj2EQEtX8ininRefG2GTrMJ/CqwmRtrUoIZ/gwmuToyu6bw33+7mKcFLwG95Vn3GN125ZgKR3boxZJetYgPmTnLLfzAozDwiBFOrlkNOB41njIwAPyCPKRjKrd2YbuVbBrRFjlLBRKZTOe6IOV4UglvkKpbOb0ugOaNnMMqWydl19B8MNOAzq7WZs2EGtpnG9H7t9YeiFUFaNYR6jYvIiJo77QyFdiFYRjdrRWmgc2zkS+L38tA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(26005)(7696005)(6506007)(55016003)(122000001)(41300700001)(9686003)(2906002)(110136005)(82960400001)(38100700002)(7416002)(921005)(54906003)(5660300002)(478600001)(8936002)(52536014)(38070700005)(66476007)(8676002)(76116006)(64756008)(86362001)(4326008)(71200400001)(66446008)(186003)(33656002)(66946007)(66556008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?62/96jFNHdcx/wtve9bw26Kjx7i0ZS44thiI1IAMZVf9GPPr5bpefcWtOxn8?=
 =?us-ascii?Q?MMRDpZkP+6rNi7X3YtL8DjJ/+nZSIjSGKchTX/EOWXNfVMQXL147rTPXtGQq?=
 =?us-ascii?Q?D8hJhiIDdP3sT5Q2Ccu3bMtMEUY8oH+Gggk9Doy7spR52fZ6HHwHS6psQqT3?=
 =?us-ascii?Q?UhIS03IJp5L3NDnm+PuiFdafaDEriUpj7vPN650/Ikes9TczaWo4rd4Owe8v?=
 =?us-ascii?Q?MLKNaogF2bLzdwIQPvQ1l7oXWn0wXZW9PbIiyQySRqUNJE2+rRdb108vsQIE?=
 =?us-ascii?Q?Gx192tZQKLAAoeVuGLZ5J3L/GH1wmz5gNxT/nZJyZ6ClmuCuIJEcjS/s0lv+?=
 =?us-ascii?Q?ea3UdVCqlFwLDnHCaZY7vYR6FO7izzwt9frYZ3brYrBQib/o+vljs4fD8a1C?=
 =?us-ascii?Q?/37JqF3jja5shCu0ghsZP9DvlaN8GKWlIZx5paH04EFfYvk3DnJsXeWctTbX?=
 =?us-ascii?Q?bhgUJmWns9qPs4d7NX7MrSkSoxmq3tGWYzLOvkwVEVfiPkY1NCrKRtfAOPnN?=
 =?us-ascii?Q?hs1AFkx71YtGwug+Qj1o9GtE5u6C8B35XuGRJxeDOAAtrQXKy2r9BmQq0qIE?=
 =?us-ascii?Q?nENnsbHY7+BSoDA1f44pyxWW7dZEjQ8BE9f5MJrTxjK+MufoTXRzPeEf+se3?=
 =?us-ascii?Q?uCHOpy0wFxAXiZ0bK01o3RcxkYcczYbeBASV3tgxq46/7aQZxsJMfsUC89Ao?=
 =?us-ascii?Q?xPN+EkdxpCvBqpl3974ITrdbGOzyHJqAaNK6ZL3xUoixPH6TE0Ny8AArzGdi?=
 =?us-ascii?Q?1LfZCvyehSIbsy7RW+SyFHdlgNp5/OagO39+6aBuJt3ISBuu0ENw3xUIKqeV?=
 =?us-ascii?Q?hquPaJfeHZeVMiE3Rnaouih9P711rKcVe/y8BwZ5ip+nJKp9ltjOrSP1xpAA?=
 =?us-ascii?Q?xMnXtOwkf0sPSQlOSeoz61LTzQmEJBbpuZadmRzKKfwqwnUv5OkkUarKTzGH?=
 =?us-ascii?Q?6RLM97zgoG1CBIBMkiJgmv/xPrEuL/eM6tMouASEsmzoOUfWVFm95Jtne+s1?=
 =?us-ascii?Q?BOlu8tFuAI2iblrvFWEsy5F+azm+SCNn41poAbJ3homkxwjguBW+D2uukRd2?=
 =?us-ascii?Q?Spxgu9Kqcbh5onNj6vR9TxX9IBBm3j3Hl6LfAAR/Wu3AwxbWPFgbGewfqbGv?=
 =?us-ascii?Q?muzX33ECXj0eB5GFuiyAb9W4itGE2aOBJKsV9GPFrMMlp9gpYaQW0GWDciyt?=
 =?us-ascii?Q?ZWqQr2zD+ksh8fQ1JAEiS50CjBnGbUc4UJ+j8MTbnHTS2SnUAJBJmSK1hjvV?=
 =?us-ascii?Q?K7E73Uk7Bh4dZzGBgBC0sU+j23e03z0C7dAhKHbzACtxuFpED+WiW0w2z6v2?=
 =?us-ascii?Q?RNeqBq1klneFRCxSAqfoosSnzj/gubnvihxiaml8SI4MJyPKwigscn1Kmp/v?=
 =?us-ascii?Q?9+WOEoxs+dRRXd3Qj077nNEGTjtDiG7ZAU3sW0cFdli97s5fDbm2FX7cdaZe?=
 =?us-ascii?Q?TvvJQzN2PpadUcnMgrquTetfQE28YzJB4ofVezHp5sFGn/zDisWzD7hhtIcC?=
 =?us-ascii?Q?dLujf/ULiz2roGtHXGxC/o2968MRIKjfZp71FlhqEE7wUKr8YQs+DVacfidM?=
 =?us-ascii?Q?8at5nnfEzW7y5Gr6l3eQg5LR1WgDOOtsc2jouc/Y?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf981295-0ce8-4406-6528-08da6bb42413
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 07:31:06.9414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1MsrgTGK1alhxkBh51AaQCYhLcuSSQ4eF0n34OJcS4y/yxT2+Ks8AIGtIdwacOSVGUT3kIUcwXgC1ZgFVzGRrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2157
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int ufshcd_mcq_config_resource(struct ufs_hba *hba)
> +{
> +       struct platform_device *pdev =3D to_platform_device(hba->dev);
> +       struct ufshcd_res_info_t *res;
> +       struct resource *res_mem, *res_mcq;
> +       int i, ret =3D 0;
> +
> +       memcpy(hba->res, ufshcd_res_info, sizeof(ufshcd_res_info));
> +
> +       for (i =3D 0; i < RES_MAX; i++) {
> +               res =3D &hba->res[i];
> +
> +               res->resource =3D platform_get_resource_byname(pdev,
> +                                                            IORESOURCE_M=
EM,
> +                                                            res->name);
> +               if (!res->resource) {
> +                       dev_info(hba->dev, "Resource %s not provided\n", =
res-
> >name);
> +                       if (i =3D=3D RES_MEM)
> +                               return -ENOMEM;
> +                       continue;
> +               } else if (i =3D=3D RES_MEM) {
> +                       res_mem =3D res->resource;
> +                       res->base =3D hba->mmio_base;
> +                       continue;
> +               }
> +
> +               res->base =3D devm_ioremap_resource(hba->dev, res->resour=
ce);
> +               if (IS_ERR(res->base)) {
> +                       dev_err(hba->dev, "Failed to map res %s, err =3D =
%d\n",
> +                                        res->name, (int)PTR_ERR(res->bas=
e));
> +                       res->base =3D NULL;
> +                       ret =3D PTR_ERR(res->base);
> +                       goto out_err;
> +               }
> +       }
> +
> +       res =3D &hba->res[RES_MCQ];
> +       /* MCQ resource provided */
> +       if (res->base)
> +               goto out;
> +
> +       /* Manually allocate MCQ resource */
Did you consider to force providing the MCQ configuration?

> +       res_mcq =3D res->resource;
> +       res_mcq =3D devm_kzalloc(hba->dev, sizeof(*res_mcq), GFP_KERNEL);
> +       if (!res_mcq) {
> +               dev_err(hba->dev, "Failed to alloate MCQ resource\n");
> +               goto out_err;
> +       }
> +       res->is_alloc =3D true;
> +
> +       res_mcq->start =3D res_mem->start +
> +                        mcq_sqattr_offset(hba->mcq_capabilities);
> +       res_mcq->end =3D res_mcq->start + 32 * MCQ_QCFG_SIZE - 1;
Shouldn't there can be MCQCap.MAXQ queues and no more than 32?


> +int ufshcd_mcq_init(struct ufs_hba *hba)
> +{
> +       struct Scsi_Host *host =3D hba->host;
> +       struct ufs_hw_queue *hwq;
> +       int i, ret =3D 0;
> +
> +       if (!is_mcq_supported(hba))
> +               return 0;
> +
> +       ret =3D ufshcd_mcq_config_resource(hba);
> +       if (ret) {
> +               dev_err(hba->dev, "Failed to config MCQ resource\n");
> +               return ret;
> +       }
> +
> +       ret =3D ufshcd_vops_config_mcq_rop(hba);
> +       if (ret) {
> +               dev_err(hba->dev, "MCQ Runtime Operation Pointers not
> configured\n");
> +               goto out_err;
> +       }
> +
> +       hba->nr_queues[HCTX_TYPE_DEFAULT] =3D num_possible_cpus();
> +       hba->nr_queues[HCTX_TYPE_READ] =3D 0;
> +       hba->nr_queues[HCTX_TYPE_POLL] =3D 1;
> +
> +       for (i =3D 0; i < HCTX_MAX_TYPES; i++)
> +               host->nr_hw_queues +=3D hba->nr_queues[i];
> +
> +       host->can_queue =3D hba->nutrs;
> +       host->cmd_per_lun =3D hba->nutrs;
> +
> +       /* One more reserved for dev_cmd_queue */
> +       hba->nr_hw_queues =3D host->nr_hw_queues + 1;
Is it possible, since MCQ memory space is *added* to the UTR & UTMR lists,
That we'll keep using the legacy doorbell for query commands?
Wouldn't it will simplify the hw_queue bookkeeping


> -#define ufshcd_hex_dump(prefix_str, buf, len) do {                      =
 \
> -       size_t __len =3D (len);                                          =
  \
> -       print_hex_dump(KERN_ERR, prefix_str,                             =
\
> -                      __len > 4 ? DUMP_PREFIX_OFFSET : DUMP_PREFIX_NONE,=
\
> -                      16, 4, buf, __len, false);                        =
\
> +#define ufshcd_hex_dump(prefix_str, buf, len) do {                     \
> +       size_t __len =3D (len);                                          =
 \
> +                                                                       \
> +       print_hex_dump(KERN_ERR, prefix_str,                            \
> +                      __len > 4 ? DUMP_PREFIX_OFFSET : DUMP_PREFIX_NONE,=
 \
> +                      16, 4, buf, __len, false);                       \
> +                                                                       \
>  } while (0)
Should this be part of this patch?

> +#define UFSHCD_MCQ_IO_QUEUE_OFFSET     1
Maybe add a comment above: "queue 0 is reserved for query commands" or some=
thing
That is if the query commands don't use the  legacy doorbell

> +static inline bool ufshcd_is_hwq_full(struct ufs_hw_queue *q)
> +{
> +       return (q->sq_hp_slot =3D=3D ((q->sq_tp_slot + 1) %
> +                                     q->max_entries));
> +}
Isn't sq_tp_slot is already % q->max_entries ?


Thanks,
Avri
